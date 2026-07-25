{ pkgs }:

pkgs.sommelier.overrideAttrs (old: {
  # Includes the upstream dmabuf fix (b/441537635). Remove this package once
  # nixpkgs' Sommelier advances beyond the pinned platform2 revision.
  version = "150.0";
  src = pkgs.fetchzip {
    url = "https://chromium.googlesource.com/chromiumos/platform2/+archive/6b613ac50aac06960880d45a735ef2f14b62ea2b/vm_tools/sommelier.tar.gz";
    stripRoot = false;
    hash = "sha256-4iE/EoAroS1wMO/QyIcy/pRfljUFU7skVBdtXJ/z/Jw=";
  };
  mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Dwith_tests=false" ];
  doCheck = false;
  nativeCheckInputs = [ ];
  postInstall = "";
  meta = old.meta // {
    broken = false;
  };
})
