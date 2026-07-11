{
  pkgs,
  username,
  nixpkgs-update,
  ...
}:

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

  home.packages = with pkgs; [
    tree
    pulsemixer
    rustup
    nodejs
    bun
    tracy
    pkg-config
    gcc
    nix-index
    nil
    nixfmt
    jq
    gh
    claude-code
    codex
    fastfetch
    obsidian
    kicad
    (import (nixpkgs-update + "/pkgs/default.nix") {
      inherit (nixpkgs-update.inputs) nixpkgs mmdoc runtimeDeps;
      self = nixpkgs-update;
      system = pkgs.stdenv.hostPlatform.system;
    }).default
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
