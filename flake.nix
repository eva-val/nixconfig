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
  };

  outputs = { self, nixpkgs, nixos-apple-silicon, home-manager, ... }: {
    nixosConfigurations.nixbook = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        inherit nixos-apple-silicon;
        hostname = "nixbook";
        username = "eva";
      };
      modules = [
        nixos-apple-silicon.nixosModules.apple-silicon-support
        home-manager.nixosModules.home-manager
        ./hosts/nixbook.nix
      ];
    };
  };
}
