{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    curl
    fish
    git
    clang
    wl-clipboard
    ripgrep
    javaPackages.compiler.temurin-bin.jre-25
    python314
  ];

  programs.firefox = {
    enable = true;
    preferences = {
      "widget.gtk.libadwaita-colors.enabled" = false;
    };
  };

  programs.fish.enable = true;

  # Nix settings
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = [
        "root"
        username
      ];
      extra-substituters = [
        "https://nixos-apple-silicon.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
