# Thunderbolt (fairydust) kernel toggle.
# When useThunderboltKernel is true, replaces the default Asahi kernel
# with the fairydust branch from github.com/AsahiLinux/linux.
{
  config,
  lib,
  pkgs,
  useThunderboltKernel,
  linux-asahi-thunderbolt,
  ...
}:

let
  cacheDir = config.programs.ccache.cacheDir;

  # Wrapper script so CC can be a single path (no spaces)
  ccache-gcc = pkgs.writeShellScript "ccache-gcc" ''
    export CCACHE_DIR="${cacheDir}"
    export CCACHE_COMPRESS=1
    export CCACHE_SLOPPINESS=random_seed
    export CCACHE_UMASK=007
    exec ${pkgs.ccache}/bin/ccache gcc "$@"
  '';
in
{
  # ccache for faster kernel rebuilds
  programs.ccache.enable = useThunderboltKernel;
  # Always set so the sandbox path is available on next rebuild
  # (avoids chicken-and-egg: the path must be active before building the kernel)
  nix.settings.extra-sandbox-paths = [ cacheDir ];

  nixpkgs.overlays = lib.optionals useThunderboltKernel [
    # Replace linux-asahi with fairydust (Thunderbolt) kernel
    (final: prev: {
      linux-asahi = final.callPackage (
        {
          lib,
          callPackage,
          linuxPackagesFor,
          _kernelPatches ? [ ],
        }:
        let
          linux-asahi-pkg =
            {
              stdenv,
              lib,
              buildLinux,
              ...
            }:
            buildLinux {
              inherit lib;
              pname = "linux-asahi";
              version = "6.18.10";
              modDirVersion = "6.18.10";
              extraMeta.branch = "6.18";

              src = linux-asahi-thunderbolt;

              extraMakeFlags = [
                "CC=${ccache-gcc}"
                "HOSTCC=${ccache-gcc}"
              ];

              kernelPatches = [
                {
                  name = "Asahi config";
                  patch = null;
                  structuredExtraConfig = with lib.kernel; {
                    ARM64_16K_PAGES = yes;
                    ARM64_MEMORY_MODEL_CONTROL = yes;
                    ARM64_ACTLR_STATE = yes;
                    APPLE_WATCHDOG = yes;
                    APPLE_M1_CPU_PMU = yes;
                    HID_APPLE = module;
                    APPLE_PMGR_MISC = yes;
                    APPLE_PMGR_PWRSTATE = yes;
                  };
                  features.rust = true;
                }
              ]
              ++ _kernelPatches;
            };
        in
        lib.recurseIntoAttrs (linuxPackagesFor (callPackage linux-asahi-pkg { }))
      ) { };
    })
  ];
}
