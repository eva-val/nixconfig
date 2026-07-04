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

  # Printing
  services.printing.enable = true;

  # Thumbnail support in file managers
  services.tumbler.enable = true;

  # Ambient light / accelerometer sensor D-Bus proxy (net.hadess.SensorProxy)
  hardware.sensor.iio.enable = true;

  # Auto-brightness driven by the AOP ALS (VD6286).
  # Upstream nixpkgs patches the udev rule but never installs it; copy it into
  # $out so services.udev.packages picks it up. (Pending PR.)
  nixpkgs.overlays = [
    (final: prev: {
      wluma = prev.wluma.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          install -Dm644 90-wluma-backlight.rules \
            $out/lib/udev/rules.d/90-wluma-backlight.rules
        '';
      });
    })
  ];
  environment.systemPackages = [ pkgs.wluma ];
  services.udev.packages = [ pkgs.wluma ];

  environment.etc."xdg/wluma/config.toml".text = ''
    [als.iio]
    path = "/sys/bus/iio/devices"
    # Fewer, wider buckets so ordinary head/light movement stays inside one
    # level instead of flipping across a boundary and ping-ponging brightness.
    thresholds = { 0 = "night", 30 = "dim", 150 = "normal", 600 = "bright" }

    [[output.backlight]]
    name = "eDP-1"
    path = "/sys/class/backlight/apple-panel-bl"
    capturer = "none"
  '';

  systemd.user.services.wluma = {
    description = "Auto-brightness from ambient light sensor";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wluma}/bin/wluma";
      Restart = "on-failure";
      RestartSec = 5;
      Environment = [ "RUST_LOG=debug" ];
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];
}
