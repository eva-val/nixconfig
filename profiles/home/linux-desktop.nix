{ pkgs, ... }:

{
  imports = [
    ../../modules/home/firefox.nix
    ../../modules/home/vscode.nix
    ../../modules/home/prismlauncher.nix
  ];

  home.packages = with pkgs; [
    pulsemixer
    wl-clipboard
    jetbrains.rust-rover
    bolt-launcher
    obsidian
    kicad
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
