_:

{
  imports = [ ../../modules/home/cosmic-theme.nix ];

  stylix.targets = {
    helix.enable = false;
    vscode.enable = false;
    firefox.profileNames = [ "default" ];
  };
}
