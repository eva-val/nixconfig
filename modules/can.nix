# PEAK PCAN-USB Pro FD CAN bus setup for the bench radio.
#
# Brings up can0/can1 as CAN-FD, 500k nominal / 2M data, sample-point 0.8, when the
# dongle enumerates (udev RUN as root). MUST be FD-configured: waking the radio
# REQUIRES FD frames (partial-network wake). Diagnostics use classic frames, which an
# FD socket can also send — so keep the bus FD. Raw CAN sockets need no capability,
# so `eva` sends with no sudo:
#     python3 radio_can.py wake          # FD wake (default)
#     python3 uds.py read-dtc ... --classic   # classic diagnostics
{ pkgs, ... }:
{
  # sample-point 0.8 / dsample-point 0.8 : MUST match the GM bus (kernel default
  #       0.875 mismatches it and causes bit errors). restart-ms 100 : auto-recover.
  # NOTE: pcan_usb_pro_fd does NOT support berr-reporting/one-shot ctrlmodes.
  #
  # can1 (device port CAN2) is the "fake bus partner": an always-awake node that ACKs
  # can0's frames. Requires CAN1+CAN2 physically jumpered onto the radio's bus.
  services.udev.extraRules = ''
    SUBSYSTEM=="net", ACTION=="add", KERNEL=="can0", RUN+="${pkgs.iproute2}/bin/ip link set can0 type can bitrate 500000 sample-point 0.8 dbitrate 2000000 dsample-point 0.8 fd on restart-ms 100", RUN+="${pkgs.iproute2}/bin/ip link set can0 up"
    SUBSYSTEM=="net", ACTION=="add", KERNEL=="can1", RUN+="${pkgs.iproute2}/bin/ip link set can1 type can bitrate 500000 sample-point 0.8 dbitrate 2000000 dsample-point 0.8 fd on restart-ms 100", RUN+="${pkgs.iproute2}/bin/ip link set can1 up"
  '';
}
