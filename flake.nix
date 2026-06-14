{
  description = "NixOS configuration for nixbook";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-apple-silicon = {
      # PR #451 (Solidsilver): Support Asahi installer vendorfw format,
      # rebased onto upstream main so binary cache hits work.
      url = "github:eva-val/nixos-apple-silicon/feat/vendorfw-support";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Asahi kernel with Thunderbolt support (fairydust branch)
    linux-asahi-thunderbolt = {
      url = "github:AsahiLinux/linux/fairydust";
      flake = false;
    };

    # Upstream wluma pinned to 4.11.0 (includes aop-sensors-als in the IIO
    # allowlist). Nixpkgs is still on 4.10.0; bump PR pending.
    wluma = {
      url = "github:max-baz/wluma/4.11.0";
      flake = false;
    };

    # ryantm's nixpkgs-update — automated package version bumper, not in nixpkgs
    nixpkgs-update.url = "github:ryantm/nixpkgs-update";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-apple-silicon,
      home-manager,
      stylix,
      linux-asahi-thunderbolt,
      wluma,
      nixpkgs-update,
      ...
    }:
    let
      useThunderboltKernel = false;
    in
    {
      formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixfmt-tree;

      nixosConfigurations.nixbook = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit
            nixos-apple-silicon
            useThunderboltKernel
            linux-asahi-thunderbolt
            wluma
            nixpkgs-update
            ;
          hostname = "nixbook";
          username = "eva";
        };
        modules = [
          nixos-apple-silicon.nixosModules.apple-silicon-support
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          ./hosts/nixbook.nix
        ];
      };
    };
}
