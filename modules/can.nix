# PEAK PCAN-USB Pro FD CAN bus setup for the bench radio.
#
# Brings up can0/can1 as CAN-FD, 500k nominal / 2M data, automatically when the
# dongle enumerates (udev RUN executes as root). Raw CAN sockets need no
# capability, so `eva` can send/recv with no sudo:
#     python3 radio_can.py wake
{ pkgs, ... }:
{
  # sample-point 0.8 / dsample-point 0.8 : MUST match the GM bus. The kernel
  #       default (0.875) mismatches the radio and produces bit errors that pile
  #       into BUS-OFF — dialing both to 0.8 is what stabilised the link.
  # restart-ms 100 : auto-recover from bus-off if it ever still happens.
  # NOTE: this PEAK (pcan_usb_pro_fd) does NOT support berr-reporting or one-shot
  #       ctrlmodes — omit them or the whole `ip link set type can` call fails.
  #
  # Both channels come up in NORMAL FD mode. can1 (device port CAN2) is the
  # "fake bus partner": an always-awake node that ACKs can0's frames so
  # transmissions complete cleanly. Requires CAN1 and CAN2 to be physically
  # jumpered onto the same bus as the radio (H<->H<->H, L<->L<->L).
  services.udev.extraRules = ''
    SUBSYSTEM=="net", ACTION=="add", KERNEL=="can0", RUN+="${pkgs.iproute2}/bin/ip link set can0 type can bitrate 500000 sample-point 0.8 dbitrate 2000000 dsample-point 0.8 fd on restart-ms 100", RUN+="${pkgs.iproute2}/bin/ip link set can0 up"
    SUBSYSTEM=="net", ACTION=="add", KERNEL=="can1", RUN+="${pkgs.iproute2}/bin/ip link set can1 type can bitrate 500000 sample-point 0.8 dbitrate 2000000 dsample-point 0.8 fd on restart-ms 100", RUN+="${pkgs.iproute2}/bin/ip link set can1 up"
  '';
}
