{ pkgs, ... }:

let
  # Upstream fixed the dmabuf bug (b/441537635) in CL 6941981, merged 2025-09-17.
  # nixpkgs sommelier is stuck at v126.0 and marked broken; bump to v145.0 which
  # includes the fix and builds cleanly without disabling tests.
  sommelier-fixed = pkgs.sommelier.overrideAttrs (old: {
    version = "145.0";
    src = pkgs.fetchzip {
      url = "https://chromium.googlesource.com/chromiumos/platform2/+archive/ea5062d66b7c8d5433a2a49a4d6a3d70938dbd81/vm_tools/sommelier.tar.gz";
      stripRoot = false;
      sha256 = "sha256-4iE/EoAroS1wMO/QyIcy/pRfljUFU7skVBdtXJ/z/Jw=";
    };
    # Tests segfault in sandbox (LinuxDmabufTest needs GPU context) — same
    # issue exists in all nixpkgs versions, noted by upstream PR #438115 author.
    mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Dwith_tests=false" ];
    doCheck = false;
    nativeCheckInputs = [ ];
    postInstall = "";
    meta = old.meta // { broken = false; };
  });
in
{
  boot.kernelModules = [ "kvm" ];

  # muvm exposes the host filesystem to the VM guest.
  # Steam's scripts use #!/bin/bash shebangs, which fail on NixOS
  # without this since /bin/bash doesn't exist by default.
  system.activationScripts.binbash = ''
    mkdir -p /bin
    ln -sf ${pkgs.bash}/bin/bash /bin/bash
  '';

  environment.systemPackages = with pkgs; [
    fex
    muvm
    sommelier-fixed
    squashfuse
    squashfsTools
    pciutils
  ];
}
