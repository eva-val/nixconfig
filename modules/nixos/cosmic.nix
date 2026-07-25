{ hostSpec, ... }:

{
  users.users.${hostSpec.username}.extraGroups = [
    "video"
    "input"
    "audio"
  ];

  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;

    xserver.xkb = {
      layout = "us";
      options = "eurosign:e,caps:escape";
    };

    libinput.enable = true;
    printing.enable = true;
    tumbler.enable = true;
  };

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
  hardware.sensor.iio.enable = true;
}
