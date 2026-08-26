{
  hostSpec,
  pkgs,
  ...
}:

{
  # Access to JTAG/SWD debug probes for embedded firmware work, such as the
  # ESP-Prog (FT2232, 0403:6010) used to debug the snoof CAN adapter.
  #
  # probe-rs ships rules covering common probes. They grant the active seat
  # access through "uaccess" and use plugdev as the fallback for processes
  # without a logind session, including coding agents. The group must exist
  # when udev parses the rule or the matching line is ignored entirely.
  #
  # The probe binaries themselves come from each project's dev shell, so only
  # the rules are installed here.
  services.udev.packages = [ pkgs.probe-rs-tools ];

  users.groups.plugdev = { };
  users.users.${hostSpec.username}.extraGroups = [ "plugdev" ];
}
