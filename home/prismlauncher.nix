{ pkgs, ... }:

{
  home.packages = [ pkgs.prismlauncher ];

  xdg.desktopEntries."org.prismlauncher.PrismLauncher" = {
    name = "Prism Launcher";
    comment = "A custom launcher for Minecraft";
    exec = "${pkgs.prismlauncher}/bin/prismlauncher %U";
    icon = "org.prismlauncher.PrismLauncher";
    terminal = false;
    type = "Application";
    categories = [
      "Game"
      "ActionGame"
      "AdventureGame"
      "Simulation"
    ];
    startupNotify = true;
    mimeType = [
      "application/zip"
      "application/x-modrinth-modpack+zip"
      "x-scheme-handler/curseforge"
      "x-scheme-handler/prismlauncher"
    ];
    settings = {
      StartupWMClass = "PrismLauncher";
      Keywords = "game;minecraft;mc;";
    };
  };
}
