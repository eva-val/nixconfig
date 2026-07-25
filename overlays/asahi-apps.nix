final: prev:

(prev.lib.composeManyExtensions [
  (import ./fex.nix)
  (import ./packages.nix)
])
  final
  prev
