{ pkgs, ... }:

{
  # Access to JTAG/SWD debug probes for embedded firmware work, such as the
  # ESP-Prog (FT2232, 0403:6010) used to debug the snoof CAN adapter.
  #
  # probe-rs ships rules covering the common probes, tagged "uaccess" so the
  # seat's logged-in user is granted access directly. That avoids adding
  # anyone to plugdev, which the rules also reference as a fallback for
  # non-seat logins. Without these, probe-rs finds the probe but reports it
  # as "(inaccessible)".
  #
  # The probe binaries themselves come from each project's dev shell, so only
  # the rules are installed here.
  services.udev.packages = [ pkgs.probe-rs-tools ];
}
