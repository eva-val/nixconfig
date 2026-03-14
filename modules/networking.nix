{ ... }:

{
  networking.networkmanager.enable = true;

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
}
