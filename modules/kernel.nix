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

{
  # Thunderbolt userspace tools
  services.hardware.bolt.enable = useThunderboltKernel;
  environment.systemPackages = lib.optionals useThunderboltKernel [ pkgs.thunderbolt ];

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
              version = "6.19.11";
              modDirVersion = "6.19.11";
              extraMeta.branch = "6.19";

              src = linux-asahi-thunderbolt;

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
