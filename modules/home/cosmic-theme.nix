_:

let
  themePath = "cosmic/com.system76.CosmicTheme.Dark/v1";
  builderPath = "cosmic/com.system76.CosmicTheme.Dark.Builder/v1";
in
{
  xdg.configFile = {
    "${themePath}" = {
      source = ../../themes/cosmic/dark-v1;
      recursive = true;
    };
    "${builderPath}" = {
      source = ../../themes/cosmic/builder-v1;
      recursive = true;
    };
  };

  # Importable theme bundles for sharing and backup.
  xdg.dataFile = {
    "cosmic-themes/witch-hazel-hypercolor-dark.ron".source =
      ../../themes/witch-hazel-hypercolor-dark.ron;
    "cosmic-themes/witch-hazel-hypercolor-terminal.ron".source =
      ../../themes/witch-hazel-hypercolor-terminal.ron;
  };
}
