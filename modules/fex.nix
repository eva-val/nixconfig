{ pkgs, ... }:

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
    (sommelier.overrideAttrs {
      meta.broken = false;
      doCheck = false;
      mesonFlags = [ "-Dwith_tests=false" ];
      nativeCheckInputs = [ ];
      postInstall = "";
    })
    squashfuse
    squashfsTools
    pciutils
  ];
}
