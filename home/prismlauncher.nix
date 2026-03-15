{ pkgs, ... }:

let
  cosmicTouchpadConfig =
    "$HOME/.config/cosmic/com.system76.CosmicComp/v1/input_touchpad";

  wrapper = pkgs.writeShellScript "prismlauncher-wrapper" ''
    CONFIG="${cosmicTouchpadConfig}"

    if [ -f "$CONFIG" ]; then
      ORIGINAL=$(${pkgs.gnused}/bin/sed -n 's/.*disable_while_typing: Some(\(.*\)).*/\1/p' "$CONFIG")
      ${pkgs.gnused}/bin/sed -i 's/disable_while_typing: Some(true)/disable_while_typing: Some(false)/' "$CONFIG"
    fi

    restore() {
      if [ -n "$ORIGINAL" ] && [ -f "$CONFIG" ]; then
        ${pkgs.gnused}/bin/sed -i "s/disable_while_typing: Some(false)/disable_while_typing: Some($ORIGINAL)/" "$CONFIG"
      fi
    }
    trap restore EXIT

    ${pkgs.prismlauncher}/bin/prismlauncher "$@"
  '';
in
{
  home.packages = [ pkgs.prismlauncher ];

  xdg.desktopEntries."org.prismlauncher.PrismLauncher" = {
    name = "Prism Launcher";
    comment = "A custom launcher for Minecraft";
    exec = "${wrapper} %U";
    icon = "org.prismlauncher.PrismLauncher";
    terminal = false;
    type = "Application";
    categories = [ "Game" "ActionGame" "AdventureGame" "Simulation" ];
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
