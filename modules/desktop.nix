{ pkgs, wluma, ... }:

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
  # Built from upstream wluma 4.11.1 (pinned in flake.nix) since nixpkgs is
  # still on 4.10.0. 4.11.0 adds `aop-sensors-als` to the IIO name allowlist.
  nixpkgs.overlays = [
    (final: prev: {
      wluma = prev.wluma.overrideAttrs (old: {
        version = "4.11.1";
        src = wluma;
        cargoDeps = final.rustPlatform.importCargoLock {
          lockFile = wluma + "/Cargo.lock";
        };
        # Upstream nixpkgs patches the rule but never installs it; copy it
        # into $out so services.udev.packages picks it up. (Pending PR.)
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
    thresholds = { 0 = "night", 20 = "dim", 80 = "normal", 250 = "bright", 500 = "outdoors" }

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
