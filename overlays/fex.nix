final: prev: {
  # FEX's build scripts need packaging.version on Python 3.14. Remove this
  # override once nixpkgs includes packaging in FEX's native build inputs.
  fex = prev.fex.overrideAttrs (old: {
    nativeBuildInputs = [
      (final.python3.withPackages (
        pythonPackages: with pythonPackages; [
          setuptools
          libclang
          packaging
        ]
      ))
    ]
    ++ (old.nativeBuildInputs or [ ]);
  });
}
