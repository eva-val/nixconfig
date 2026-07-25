{ pkgs }:

let
  # muvm's -f option requires an EROFS root filesystem.
  fexRootfs = pkgs.fetchurl {
    url = "https://rootfs.fex-emu.gg/Ubuntu_24_04/2025-12-27/Ubuntu_24_04.ero";
    hash = "sha256-1+ZbuNAnbFuMI+ibXntnirx8tQZkGYeQUiOEpJv+uRE=";
  };
in
pkgs.writeShellScriptBin "muvm-shell" ''
  exec ${pkgs.muvm}/bin/muvm \
    -f ${fexRootfs} \
    -i -t \
    -- /bin/bash "$@"
''
