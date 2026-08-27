{
  hostSpec,
  lib,
  pkgs,
  ...
}:

let
  canDevices = [
    {
      name = "pcan0";
      channelId = "0x0";
      match = ''ENV{ID_NET_DRIVER}=="peak_usb", ENV{ID_VENDOR_ID}=="0c72", ENV{ID_MODEL_ID}=="0011"'';
      fd = true;
      autoRestart = true;
    }
    {
      name = "pcan1";
      channelId = "0x1";
      match = ''ENV{ID_NET_DRIVER}=="peak_usb", ENV{ID_VENDOR_ID}=="0c72", ENV{ID_MODEL_ID}=="0011"'';
      fd = true;
      autoRestart = true;
    }
    {
      name = "snoof0";
      channelId = "0x0";
      match = ''ENV{ID_NET_DRIVER}=="gs_usb", ENV{ID_VENDOR_ID}=="1d50", ENV{ID_MODEL_ID}=="606f", ENV{ID_SERIAL_SHORT}=="68EE8F5B3E44"'';
      fd = true;
      autoRestart = false;
    }
    {
      name = "snoof1";
      channelId = "0x1";
      match = ''ENV{ID_NET_DRIVER}=="gs_usb", ENV{ID_VENDOR_ID}=="1d50", ENV{ID_MODEL_ID}=="606f", ENV{ID_SERIAL_SHORT}=="68EE8F5B3E44"'';
      fd = false;
      autoRestart = false;
    }
  ];

  ip = "/run/current-system/sw/bin/ip";
  usbreset = "/run/current-system/sw/bin/usbreset";
  storeIp = "${pkgs.iproute2}/bin/ip";

  renameInterface =
    device:
    ''SUBSYSTEM=="net", ACTION=="add", ${device.match}, ATTR{dev_id}=="${device.channelId}", NAME:="${device.name}", TAG+="systemd"'';

  canProfile =
    device:
    "bitrate 500000 sample-point 0.8"
    + lib.optionalString device.fd " dbitrate 2000000 dsample-point 0.8 fd on"
    + " cc-len8-dlc on"
    + lib.optionalString device.autoRestart " restart-ms 100";

  configureInterface =
    device:
    lib.nameValuePair "can-setup-${device.name}" {
      description = "Configure ${device.name} CAN interface";
      bindsTo = [ "sys-subsystem-net-devices-${device.name}.device" ];
      after = [ "sys-subsystem-net-devices-${device.name}.device" ];
      wantedBy = [ "sys-subsystem-net-devices-${device.name}.device" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = [
          "${storeIp} link set ${device.name} down"
          "${storeIp} link set ${device.name} type can ${canProfile device}"
          "${storeIp} link set ${device.name} up"
        ];
      };
    };

  passwordlessCanCommands =
    device:
    map
      (command: {
        inherit command;
        options = [ "NOPASSWD" ];
      })
      [
        "${ip} link set ${device.name} up"
        "${ip} link set ${device.name} down"
        "${ip} link set ${device.name} type can ${canProfile device}"
      ];
in
{
  users.users.${hostSpec.username}.extraGroups = [ "dialout" ];
  environment.systemPackages = [
    pkgs.can-utils
    pkgs.usbutils
  ];

  # Stable names preserve the physical PEAK 0 <-> snoof 0 and PEAK 1 <->
  # snoof 1 pairing regardless of USB probe order. The snoof match is pinned
  # to this adapter because channel 1 is classic-only; the PEAK has no serial.
  services.udev.extraRules = lib.concatMapStringsSep "\n" renameInterface canDevices;

  # Configure after udev has completed each rename. PEAK 0/1 and snoof 0 use
  # CAN-FD; snoof 1 uses classic CAN with the same arbitration bitrate. Keep
  # raw Classical CAN DLC values 9..15 so the bench exercises the legal
  # CC_LEN8_DLC path instead of silently normalizing them to DLC 8.
  systemd.services = lib.listToAttrs (map configureInterface canDevices);

  # Permit only the declared profiles and link state changes without granting
  # unrestricted `ip`, whose namespace commands can execute programs as root.
  # The exact snoof serial is also allowed through usbreset for bounded USB
  # lifecycle fault injection without access to any other USB device.
  security.sudo.extraRules = [
    {
      users = [ hostSpec.username ];
      commands = lib.concatMap passwordlessCanCommands canDevices ++ [
        {
          command = "${usbreset} SN:68EE8F5B3E44";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
