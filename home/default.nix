{ pkgs, username, ... }:

{
  imports = [
    ./git.nix
    ./fish.nix
    ./starship.nix
    ./vscode.nix
    ./direnv.nix
    ./prismlauncher.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    tree
    bambu-studio
    pulseaudio
    rustup
    gcc
    nix-index
    nil
    nixfmt
    jq
    gh
    fastfetch
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  programs.home-manager.enable = true;
}
