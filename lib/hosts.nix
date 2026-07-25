{ inputs }:

let
  homeManagerModule = hostSpec: homeModules: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = { inherit inputs hostSpec; };
      users.${hostSpec.username} = {
        imports = homeModules;

        home.username = hostSpec.username;
        home.homeDirectory = hostSpec.homeDirectory;
        programs.home-manager.enable = true;
      };
    };
  };
in
{
  mkNixosHost =
    {
      hostSpec,
      modules ? [ ],
      homeModules ? [ ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit (hostSpec) system;
      specialArgs = { inherit inputs hostSpec; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        (homeManagerModule hostSpec homeModules)
        { networking.hostName = hostSpec.hostname; }
      ]
      ++ modules;
    };

  # Kept lazy until a real Mac exists. Pass a nix-darwin flake input as
  # `nixDarwin`; this repository intentionally does not pin an unused input.
  mkDarwinHost =
    {
      nixDarwin,
      hostSpec,
      modules ? [ ],
      homeModules ? [ ],
    }:
    nixDarwin.lib.darwinSystem {
      specialArgs = { inherit inputs hostSpec; };
      modules = [
        inputs.home-manager.darwinModules.home-manager
        (homeManagerModule hostSpec homeModules)
        {
          nixpkgs.hostPlatform = hostSpec.system;
          networking.hostName = hostSpec.hostname;
          system.primaryUser = hostSpec.username;
          users.users.${hostSpec.username}.home = hostSpec.homeDirectory;
        }
      ]
      ++ modules;
    };
}
