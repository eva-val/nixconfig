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

    # ryantm's nixpkgs-update — automated package version bumper, not in nixpkgs
    nixpkgs-update.url = "github:ryantm/nixpkgs-update";

    # sadjow's claude-code — tracks latest Claude Code release ahead of nixpkgs
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sadjow's codex-cli — tracks latest Codex CLI release ahead of nixpkgs
    codex-cli = {
      url = "github:sadjow/codex-cli-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    steambattery = {
      url = "github:eva-val/steambattery";
      inputs.nixpkgs.follows = "nixpkgs";
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
      nixpkgs-update,
      claude-code,
      codex-cli,
      steambattery,
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
            nixpkgs-update
            steambattery
            ;
          hostname = "nixbook";
          username = "eva";
        };
        modules = [
          nixos-apple-silicon.nixosModules.apple-silicon-support
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          {
            nixpkgs.overlays = [
              claude-code.overlays.default
              codex-cli.overlays.default
            ];
          }
          ./hosts/nixbook.nix
        ];
      };
    };
}
