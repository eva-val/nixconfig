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
    fastfetch
    javaPackages.compiler.temurin-bin.jre-25
    claude-code
  ];

  programs.firefox = {
    enable = true;
    preferences = {
      "widget.gtk.libadwaita-colors.enabled" = false;
    };
  };

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Eva Valentine";
        email = "stephanie.howanietz@pm.me";
        signingkey = "~/.ssh/id_ed25519.pub";
      };
      commit.gpgsign = true;
      gpg.format = "ssh";
      init.defaultBranch = "main";
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      pbcopy = "wl-copy";
      pbpaste = "wl-paste";
      rebuild = "sudo nixos-rebuild switch --flake /home/${username}/nixconfig#nixbook --impure";
    };
  };

  programs.starship.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Nix settings
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" username ];
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
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
