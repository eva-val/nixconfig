{
  hostSpec,
  inputs,
  ...
}:

{
  imports = [
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ../../profiles/nixos/base.nix
    ../../profiles/nixos/cosmic-workstation.nix
    ../../modules/nixos/asahi.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/wluma.nix
    ../../modules/nixos/can.nix
    ../../modules/nixos/probe-rs.nix
    ../../modules/nixos/pynet.nix
    ../../modules/nixos/apps/android-studio.nix
    ../../modules/nixos/apps/bambu-studio.nix
    ../../modules/nixos/apps/steam.nix
    ../../modules/nixos/apps/steambattery.nix
  ];

  system.stateVersion = "25.11";

  # Keep this host's identity data next to its composition.
  users.users.${hostSpec.username}.openssh.authorizedKeys.keyFiles = [
    ../../users/eva/id_ed25519.pub
  ];
}
