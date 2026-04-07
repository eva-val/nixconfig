{
  description = "NixOS configuration for nixbook";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-apple-silicon,
      home-manager,
      stylix,
      linux-asahi-thunderbolt,
      ...
    }:
    let
      useThunderboltKernel = true;
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
