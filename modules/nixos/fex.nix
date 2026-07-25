{
  hostSpec,
  lib,
  pkgs,
  ...
}:

{
  assertions = [
    {
      assertion = pkgs.stdenv.hostPlatform.isAarch64;
      message = "The FEX/muvm feature is only supported on aarch64-linux.";
    }
  ];

  nixpkgs.overlays = [ (import ../../overlays/asahi-apps.nix) ];

  users.users.${hostSpec.username}.extraGroups = [ "kvm" ];
  boot.kernelModules = [ "kvm" ];

  # qemu-user is used only for build-time execution of x86_64 derivations.
  # Runtime translation stays inside muvm/FEX.
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  # Vendor scripts inside the guest expect this conventional shebang target.
  systemd.tmpfiles.rules = [
    "L+ /bin/bash - - - - ${lib.getExe pkgs.bash}"
  ];

  environment.systemPackages = with pkgs; [
    fex
    muvm
    muvm-shell
    sommelier-fixed
    squashfuse
    squashfsTools
    pciutils
  ];
}
