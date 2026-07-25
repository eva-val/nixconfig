{
  muvmSupport,
  pkgs,
}:

let
  inherit (muvmSupport) mkMuvmApp pkgsX86;
  pulseConfig = pkgs.writeText "pulse.conf" ''
    enable-shm=no
  '';
in
mkMuvmApp {
  package = pkgsX86.steam;
  binaryName = "steam";
  pname = "muvm-steam";
  description = "Steam wrapped to run through muvm/FEX on Apple Silicon";
  extraMuvmArgs = [
    "-e"
    "PULSE_CLIENTCONFIG=${pulseConfig}"
  ];
}
