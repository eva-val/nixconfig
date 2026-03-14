{ username, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      pbcopy = "wl-copy";
      pbpaste = "wl-paste";
      rebuild = "sudo nixos-rebuild switch --flake /home/${username}/nixconfig#nixbook --impure";
      flakeup = "nix flake update --flake /home/${username}/nixconfig";
    };
  };
}
