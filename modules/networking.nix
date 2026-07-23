{ ... }:

{
  networking.networkmanager.enable = true;

  # TEMPORARY: disable all NixOS firewall filtering.
  networking.firewall.enable = false;

  # Automatic timezone via geolocation
  services.automatic-timezoned.enable = true;

  # SSH — key-only authentication
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # Tailscale VPN
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # DNS
  services.resolved.enable = true;

  # Battery: let the Broadcom WiFi (01:00.0) and Bluetooth (01:00.1) PCI
  # radios enter runtime PM autosuspend when idle. powertop flagged both as
  # stuck "on"; vendor 0x14e4 = Broadcom, matching both functions.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x14e4", ATTR{power/control}="auto"
  '';
}
