_:

{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.default.settings."widget.gtk.libadwaita-colors.enabled" = false;
  };
}
