# Steam Controller 2 battery monitor: hidraw access, the steambatteryd user
# service, and the COSMIC panel applet. All provided by the flake module in
# the steambattery repo (hidraw access there grants via group+mode, since
# uaccess doesn't apply on this Asahi machine — see the repo module).
{ steambattery, ... }:
{
  imports = [ steambattery.nixosModules.default ];

  hardware.steambattery.enable = true;
}
