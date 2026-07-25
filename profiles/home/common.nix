{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/fish.nix
    ../../modules/home/starship.nix
    ../../modules/home/direnv.nix
  ];

  home.packages = with pkgs; [
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
    btop
    tmux
    rsync
    eza
    bat
    gh
    nix-index
    fastfetch
    inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.codex-cli.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
