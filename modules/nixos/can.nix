{
  hostSpec,
  lib,
  pkgs,
  ...
}:

let
  canInterfaces = [
    "can0"
    "can1"
  ];
  ip = "/run/current-system/sw/bin/ip";
  configureInterface =
    interface:
    ''SUBSYSTEM=="net", ACTION=="add", KERNEL=="${interface}", RUN+="${pkgs.iproute2}/bin/ip link set ${interface} type can bitrate 500000 sample-point 0.8 dbitrate 2000000 dsample-point 0.8 fd on restart-ms 100", RUN+="${pkgs.iproute2}/bin/ip link set ${interface} up"'';
  passwordlessCanCommands =
    interface:
    map
      (command: {
        inherit command;
        options = [ "NOPASSWD" ];
      })
      [
        "${ip} link set ${interface} up"
        "${ip} link set ${interface} down"
        "${ip} link set ${interface} type can *"
      ];
in
{
  users.users.${hostSpec.username}.extraGroups = [ "dialout" ];
  environment.systemPackages = [ pkgs.can-utils ];

  # PEAK PCAN-USB Pro FD bench setup. Both ports remain CAN-FD so partial-
  # network wake frames work; classic diagnostic frames remain valid.
  services.udev.extraRules = lib.concatMapStringsSep "\n" configureInterface canInterfaces;

  # Permit bench reconfiguration without granting unrestricted `ip`, whose
  # namespace subcommands can execute arbitrary programs as root.
  security.sudo.extraRules = [
    {
      users = [ hostSpec.username ];
      commands = lib.concatMap passwordlessCanCommands canInterfaces;
    }
  ];
}
