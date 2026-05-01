{ pkgs, ... }:

{
  # COSMIC desktop
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  # Keyboard layout
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Input
  services.libinput.enable = true;
  services.libinput.touchpad.disableWhileTyping = true;
  services.libinput.touchpad.additionalOptions = ''
    Option "PalmDetection" "true"
    Option "PalmMinWidth" "3"
    Option "PalmMinZ" "70"
  '';

  # Printing
  services.printing.enable = true;

  # Thumbnail support in file managers
  services.tumbler.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];
}
