{ hostSpec, ... }:

{
  users.users.${hostSpec.username}.extraGroups = [ "networkmanager" ];

  networking.networkmanager.enable = true;
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

    # Let the Broadcom Wi-Fi and Bluetooth PCI functions autosuspend.
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x14e4", ATTR{power/control}="auto"
    '';
  };
}
