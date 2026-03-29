{ pkgs, ... }:

{
  stylix = {
    enable = true;
    polarity = "dark";

    # Witchhazel Hypercolor base16 mapping
    base16Scheme = {
      scheme = "Witchhazel Hypercolor";
      author = "Stargirl Flowers (base16 by eva)";
      base00 = "282634"; # iris - Default Background
      base01 = "433e56"; # purple - Lighter Background
      base02 = "8077a8"; # nightshade - Selection
      base03 = "8a8a8a"; # stone - Comments
      base04 = "bfbfbf"; # smoke - Dark Foreground
      base05 = "f8f8f0"; # bone - Default Foreground
      base06 = "c6c4cc"; # cloud - Light Foreground
      base07 = "dcc8ff"; # lilac - Light Background
      base08 = "ffb8d1"; # peony - Variables, Tags, Errors
      base09 = "ae81ff"; # darklilac - Constants, Booleans
      base0A = "fff9a3"; # scotchbroom - Classes, Search
      base0B = "81eeff"; # carolina - Strings
      base0C = "46becb"; # sound - Support, Regex, Escapes
      base0D = "c5a3ff"; # aster - Functions
      base0E = "81ffbe"; # fern - Keywords
      base0F = "dc7070"; # brick - Deprecated
    };

    image = "${pkgs.nixos-artwork.wallpapers.catppuccin-macchiato}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-macchiato.png";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };
      serif = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };
      sizes = {
        terminal = 14;
        applications = 12;
      };
    };

  };
}
