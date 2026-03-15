{ hostname, username, ... }:

{
  imports = [
    ../hardware-configuration.nix
    ../modules/boot.nix
    ../modules/kernel.nix
    ../modules/networking.nix
    ../modules/desktop.nix
    ../modules/programs.nix
    ../modules/fex.nix
    ../modules/user.nix
  ];

  networking.hostName = hostname;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = { inherit username; };
    users.${username} = import ../home;
  };

  system.stateVersion = "25.11";
}
