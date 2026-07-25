{
  description = "Multi-host NixOS and Home Manager configuration";

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

    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      hostLib = import ./lib/hosts.nix { inherit inputs; };
      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = lib.genAttrs supportedSystems;

      nixbook = {
        hostname = "nixbook";
        system = "aarch64-linux";
        username = "eva";
        homeDirectory = "/home/eva";
      };

      nixbookPkgs = import nixpkgs {
        inherit (nixbook) system;
        config.allowUnfree = true;
        overlays = [ self.overlays.asahi-apps ];
      };
    in
    {
      lib = hostLib;

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

      overlays = {
        asahi-apps = import ./overlays/asahi-apps.nix;
        wluma = import ./overlays/wluma.nix;
        default = import ./overlays/default.nix;
      };

      packages.aarch64-linux = {
        inherit (nixbookPkgs)
          android-studio-aarch64
          muvm-bambu-studio
          muvm-shell
          muvm-steam
          sommelier-fixed
          ;
        default = nixbookPkgs.muvm-steam;
      };

      nixosModules = {
        base = import ./profiles/nixos/base.nix;
        cosmic-workstation = import ./profiles/nixos/cosmic-workstation.nix;
        asahi = import ./modules/nixos/asahi.nix;
        networking = import ./modules/nixos/networking.nix;
        wluma = import ./modules/nixos/wluma.nix;
        can = import ./modules/nixos/can.nix;
        pynet = import ./modules/nixos/pynet.nix;
        fex = import ./modules/nixos/fex.nix;
        android-studio = import ./modules/nixos/apps/android-studio.nix;
        bambu-studio = import ./modules/nixos/apps/bambu-studio.nix;
        steam = import ./modules/nixos/apps/steam.nix;
        steambattery = import ./modules/nixos/apps/steambattery.nix;
      };

      homeModules = {
        common = import ./profiles/home/common.nix;
        development = import ./profiles/home/development.nix;
        linux-desktop = import ./profiles/home/linux-desktop.nix;
        cosmic = import ./profiles/home/cosmic.nix;
      };

      nixosConfigurations.nixbook = hostLib.mkNixosHost {
        hostSpec = nixbook;
        modules = [ ./hosts/nixbook/default.nix ];
        homeModules = [ ./hosts/nixbook/home.nix ];
      };

      checks.aarch64-linux = {
        formatting =
          nixbookPkgs.runCommand "nixconfig-formatting"
            {
              nativeBuildInputs = [ nixbookPkgs.nixfmt ];
              src = lib.cleanSource ./.;
            }
            ''
              cp -r "$src" source
              chmod -R u+w source
              cd source
              nixfmt --check $(find . -name '*.nix' -type f)
              touch "$out"
            '';

        lint =
          nixbookPkgs.runCommand "nixconfig-lint"
            {
              nativeBuildInputs = with nixbookPkgs; [
                deadnix
                statix
              ];
              src = lib.cleanSource ./.;
            }
            ''
              cp -r "$src" source
              chmod -R u+w source
              cd source
              deadnix --fail --exclude hosts/nixbook/hardware-configuration.nix .
              statix check --ignore 'hosts/nixbook/hardware-configuration.nix' .
              touch "$out"
            '';

        nixbook = self.nixosConfigurations.nixbook.config.system.build.toplevel;
      };
    };
}
