{ pkgs, username, ... }:

{
  imports = [
    ./git.nix
    ./fish.nix
    ./starship.nix
    ./vscode.nix
    ./direnv.nix
    ./helix.nix
    ./prismlauncher.nix
    ./cosmic-theme.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  gtk.gtk4.theme = null;

  home.packages = with pkgs; [
    tree
    bambu-studio
    pulsemixer
    rustup
    gcc
    nix-index
    nil
    nixfmt
    jq
    gh
    claude-code
    fastfetch
    obsidian
    kicad
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  # Disable Stylix for apps with official Witchhazel themes
  stylix.targets = {
    helix.enable = false; # official witchhazel_hyper port
    vscode.enable = false; # official theaflowers extension
  };

  programs.home-manager.enable = true;
}
