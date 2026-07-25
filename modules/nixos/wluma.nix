{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../../overlays/wluma.nix) ];

  environment.systemPackages = [ pkgs.wluma ];
  services.udev.packages = [ pkgs.wluma ];

  environment.etc."xdg/wluma/config.toml".text = ''
    [als.iio]
    path = "/sys/bus/iio/devices"
    # Wide buckets prevent ordinary movement from oscillating at a boundary.
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
    };
  };
}
