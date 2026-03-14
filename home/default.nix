{ pkgs, username, ... }:

{
  imports = [
    ./git.nix
    ./fish.nix
    ./starship.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    tree
    prismlauncher
    bambu-studio
    pulseaudio
    rustup
    gcc
    nix-index
    vscode
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  programs.home-manager.enable = true;
}
