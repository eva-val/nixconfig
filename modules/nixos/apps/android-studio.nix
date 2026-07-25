{ pkgs, ... }:

{
  imports = [ ../fex.nix ];

  # systemd 258+ supplies device uaccess for physical Android devices.
  environment.systemPackages = [
    pkgs.android-studio-aarch64
    pkgs.android-tools
  ];
}
