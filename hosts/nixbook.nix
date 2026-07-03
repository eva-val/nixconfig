{
  hostname,
  username,
  nixpkgs-update,
  ...
}:

{
  imports = [
    ../hardware-configuration.nix
    ../modules/boot.nix
    ../modules/kernel.nix
    ../modules/networking.nix
    ../modules/desktop.nix
    ../modules/programs.nix
    ../modules/fex.nix
    ../modules/steam.nix
    ../modules/steambattery.nix
    ../modules/android-studio.nix
    ../modules/bambu-studio.nix
    ../modules/keybindings.nix
    ../modules/stylix.nix
    ../modules/user.nix
  ];

  networking.hostName = hostname;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = { inherit username nixpkgs-update; };
    users.${username} = import ../home;
  };

  system.stateVersion = "25.11";
}
