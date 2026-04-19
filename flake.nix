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

      # Overlay asahi-audio to patch speaker DSP filter graphs:
      #  1. Insert zeroramp nodes to eliminate pops/clicks on play/pause
      #     (upstream PipeWire 1.6.0 feature, ref: AsahiLinux/asahi-audio#18)
      #  2. Add delay nodes on tweeter outputs to compensate for the latency
      #     added by woofer_bp + woofer_lim on the woofer path (480 samples
      #     at 48kHz = 10ms), fixing pops/crackle during seeks/scrubbing
      asahi-audio-dsp-fix = final: prev: {
        asahi-audio = prev.asahi-audio.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.python3 ];
          postFixup = (old.postFixup or "") + ''
            for graph in $out/share/asahi-audio/*/graph.json; do
              python3 - "$graph" << 'PYEOF'
            import json, re, sys

            with open(sys.argv[1]) as f:
                raw = f.read()

            # Strip trailing commas before } or ] (non-standard JSON)
            raw = re.sub(r',\s*([}\]])', r'\1', raw)
            data = json.loads(raw)

            fg = data["filter.graph"]
            nodes = fg["nodes"]
            links = fg["links"]
            outputs = fg["outputs"]

            # 1) Prepend zeroramp nodes
            nodes[:0] = [
                {
                    "type": "builtin",
                    "label": "zeroramp",
                    "name": "zeroL",
                    "control": {"Gap (s)": 0.08, "Duration (s)": 0.08},
                },
                {
                    "type": "builtin",
                    "label": "zeroramp",
                    "name": "zeroR",
                    "control": {"Gap (s)": 0.08, "Duration (s)": 0.08},
                },
            ]
            # Route inputs through zeroramp
            fg["inputs"] = ["zeroL:In", "zeroR:In"]
            links[:0] = [
                {"output": "zeroL:Out", "input": "bassex:in_l"},
                {"output": "zeroR:Out", "input": "bassex:in_r"},
            ]

            # 2) Add delay nodes to align tweeter path with woofer path.
            #    woofer_bp + woofer_lim add ~480 samples latency at 48kHz (10ms)
            #    that the tweeter path doesn't have.
            nodes.extend([
                {
                    "type": "builtin",
                    "label": "delay",
                    "name": "delayLT",
                    "config": {"max-delay": 0.04},
                    "control": {"Delay (s)": 0.02},
                },
                {
                    "type": "builtin",
                    "label": "delay",
                    "name": "delayRT",
                    "config": {"max-delay": 0.04},
                    "control": {"Delay (s)": 0.02},
                },
            ])

            # Route tweeter convolvers through delay
            links.extend([
                {"output": "convLT:Out", "input": "delayLT:In"},
                {"output": "convRT:Out", "input": "delayRT:In"},
            ])

            # Replace tweeter outputs with delayed versions
            fg["outputs"] = [
                o.replace("convLT:Out", "delayLT:Out").replace("convRT:Out", "delayRT:Out")
                for o in outputs
            ]

            with open(sys.argv[1], "w") as f:
                json.dump(data, f, indent=4)
            PYEOF
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
          { nixpkgs.overlays = [ asahi-audio-dsp-fix ]; }
          nixos-apple-silicon.nixosModules.apple-silicon-support
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          ./hosts/nixbook.nix
        ];
      };
    };
}
