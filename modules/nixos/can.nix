{
  hostSpec,
  lib,
  pkgs,
  ...
}:

let
  configureInterface =
    interface:
    ''SUBSYSTEM=="net", ACTION=="add", KERNEL=="${interface}", RUN+="${pkgs.iproute2}/bin/ip link set ${interface} type can bitrate 500000 sample-point 0.8 dbitrate 2000000 dsample-point 0.8 fd on restart-ms 100", RUN+="${pkgs.iproute2}/bin/ip link set ${interface} up"'';
in
{
  users.users.${hostSpec.username}.extraGroups = [ "dialout" ];
  environment.systemPackages = [ pkgs.can-utils ];

  # PEAK PCAN-USB Pro FD bench setup. Both ports remain CAN-FD so partial-
  # network wake frames work; classic diagnostic frames remain valid.
  services.udev.extraRules = lib.concatMapStringsSep "\n" configureInterface [
    "can0"
    "can1"
  ];
}
