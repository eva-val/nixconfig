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
      useThunderboltKernel = false;

      # Overlay asahi-audio to insert zeroramp nodes into speaker DSP graphs.
      # Eliminates pops/clicks on play/pause by ramping silence transitions.
      # Upstream PipeWire added zeroramp in 1.6.0 but asahi-audio hasn't
      # integrated it yet (ref: AsahiLinux/asahi-audio#18).
      asahi-audio-zeroramp = final: prev: {
        asahi-audio = prev.asahi-audio.overrideAttrs (old: {
          postFixup = (old.postFixup or "") + ''
            for graph in $out/share/asahi-audio/*/graph.json; do
              # Add zeroramp nodes at start of nodes array
              sed -i 's|"nodes": \[|"nodes": [\n            {\n                "type": "builtin",\n                "label": "zeroramp",\n                "name": "zeroL"\n            },\n            {\n                "type": "builtin",\n                "label": "zeroramp",\n                "name": "zeroR"\n            },|' "$graph"

              # Route graph inputs through zeroramp
              sed -i '/"inputs"/,/\]/{s|"bassex:in_l"|"zeroL:In"|; s|"bassex:in_r"|"zeroR:In"|}' "$graph"

              # Add zeroramp->bassex links at start of links array
              sed -i 's|{"output": "bassex:out_l", "input": "ell:in"}|{"output": "zeroL:Out", "input": "bassex:in_l"},\n            {"output": "zeroR:Out", "input": "bassex:in_r"},\n            {"output": "bassex:out_l", "input": "ell:in"}|' "$graph"
            done
          '';
        });
      };
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
          { nixpkgs.overlays = [ asahi-audio-zeroramp ]; }
          nixos-apple-silicon.nixosModules.apple-silicon-support
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          ./hosts/nixbook.nix
        ];
      };
    };
}
