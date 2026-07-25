{
  config,
  hostSpec,
  lib,
  pkgs,
  ...
}:

let
  flakeDirectory = "${config.home.homeDirectory}/nixconfig";
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      flakeup = "nix flake update --flake ${flakeDirectory}";
    }
    // lib.optionalAttrs pkgs.stdenv.isLinux {
      pbcopy = "wl-copy";
      pbpaste = "wl-paste";
      rebuild = "sudo nixos-rebuild switch --flake ${flakeDirectory}#${hostSpec.hostname} --impure";
    };
  };
}
