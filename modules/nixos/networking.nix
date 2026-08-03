{ hostSpec, ... }:

{
  users.users.${hostSpec.username}.extraGroups = [ "networkmanager" ];

  networking.networkmanager = {
    enable = true;

    # Asahi recommends iwd for the Broadcom adapters used in Macs. It also
    # avoids wpa_supplicant's P2P interface, which this BCM4387 rejects and
    # which can leave wireless scans pending.
    wifi = {
      backend = "iwd";
      powersave = false;
    };
  };
  networking.firewall.enable = true;

  services = {
    automatic-timezoned.enable = true;

    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "client";
    };

    resolved.enable = true;

    # The BCM4387 can remain logically connected while Ethernet is preferred
    # but fail to wake for Wi-Fi fallback. Keep Wi-Fi awake; Bluetooth may
    # still autosuspend. Revisit once brcmfmac no longer reports -52 P2P
    # failures and malformed scan events on this hardware.
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x14e4", ATTR{device}=="0x4433", ATTR{power/control}="on"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x14e4", ATTR{device}=="0x5f71", ATTR{power/control}="auto"
    '';
  };
}
