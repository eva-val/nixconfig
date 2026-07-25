{
  hostSpec,
  pkgs,
  ...
}:

{
  users.users.${hostSpec.username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };

  programs.fish.enable = true;
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = [
        "root"
        hostSpec.username
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://claude-code.cachix.org"
        "https://codex-cli.cachix.org"
      ];
      extra-trusted-public-keys = [
        "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk="
        "codex-cli.cachix.org-1:1Br3H1hHoRYG22n//cGKJOk3cQXgYobUel6O8DgSing="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  environment.systemPackages = with pkgs; [
    # Kept system-wide because Clang and Home Manager's GCC both ship ld.gold.
    clang

    # Machine administration and network diagnostics.
    powertop
    nmap
    inetutils
    mtr
    iperf3
    tcpdump
    whois
    socat
    ethtool
    iftop
    nload
    speedtest-cli
  ];
}
