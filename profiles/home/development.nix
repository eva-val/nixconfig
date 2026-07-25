{ pkgs, ... }:

{
  imports = [ ../../modules/home/helix.nix ];

  home.packages = with pkgs; [
    gcc
    rustup
    python314
    nodejs
    bun
    javaPackages.compiler.temurin-bin.jre-25
    tracy
    pkg-config
    nil
    nixfmt
    openssl
  ];
}
