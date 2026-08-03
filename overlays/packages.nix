final: _prev:

let
  muvmSupport = import ../packages/muvm-support.nix {
    inherit (final) lib;
    pkgs = final;
  };
in
{
  android-studio-aarch64 = import ../packages/android-studio-aarch64.nix {
    inherit (final) lib;
    pkgs = final;
  };

  fireconnect = import ../packages/fireconnect.nix {
    inherit (final) lib;
    pkgs = final;
  };

  muvm-bambu-studio = import ../packages/muvm-bambu-studio.nix {
    inherit muvmSupport;
  };

  muvm-steam = import ../packages/muvm-steam.nix {
    inherit muvmSupport;
    pkgs = final;
  };

  muvm-shell = import ../packages/muvm-shell.nix { pkgs = final; };
  sommelier-fixed = import ../packages/sommelier-fixed.nix { pkgs = final; };
}
