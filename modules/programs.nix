{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    # Editors / shell
    vim
    fish

    # Core CLI utilities
    git
    wget
    curl
    ripgrep
    fd
    fzf
    jq
    tree
    file
    unzip
    zip
    p7zip
    htop
    btop
    powertop
    tmux
    rsync
    eza
    bat
    less
    killall

    # Network tools
    dig
    nmap
    inetutils # ping, traceroute, telnet, etc.
    mtr
    iperf3
    tcpdump
    nettools # ifconfig, netstat, route, arp
    whois
    socat
    ldns # drill
    ethtool
    iftop
    nload
    speedtest-cli
    openssl
    can-utils # cansend, candump, etc. (SocketCAN)

    # Development toolchains
    clang
    rustup
    python314
    javaPackages.compiler.temurin-bin.jre-25

    # Desktop / app
    wl-clipboard
    jetbrains.rust-rover
    bolt-launcher
  ];

  programs.firefox = {
    enable = true;
    preferences = {
      "widget.gtk.libadwaita-colors.enabled" = false;
    };
  };

  # Use JetBrains' native Wayland AWT toolkit so it picks up COSMIC's scale
  # natively instead of rendering blurry through XWayland.
  environment.sessionVariables._JAVA_OPTIONS = "-Dawt.toolkit.name=WLToolkit -Dsun.java2d.uiScale=2.0";

  programs.fish.enable = true;

  programs.nix-ld.enable = true;

  # Nix settings
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      # Fanless laptop — cap build parallelism to avoid thermal throttling.
      # Peak load ≈ max-jobs × cores; keep it well under the 8 cores.
      max-jobs = 2;
      cores = 2;
      trusted-users = [
        "root"
        username
      ];
      extra-substituters = [
        "https://nixos-apple-silicon.cachix.org"
        "https://claude-code.cachix.org"
        "https://codex-cli.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
        "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk="
        "codex-cli.cachix.org-1:1Br3H1hHoRYG22n//cGKJOk3cQXgYobUel6O8DgSing="
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
