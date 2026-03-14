{ hostname, ... }:

{
  imports = [
    ../hardware-configuration.nix
    ../modules/boot.nix
    ../modules/networking.nix
    ../modules/desktop.nix
    ../modules/programs.nix
    ../modules/user.nix
  ];

  networking.hostName = hostname;

  system.stateVersion = "25.11";
}
