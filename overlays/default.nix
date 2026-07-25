final: prev:

(prev.lib.composeManyExtensions [
  (import ./asahi-apps.nix)
  (import ./wluma.nix)
])
  final
  prev
