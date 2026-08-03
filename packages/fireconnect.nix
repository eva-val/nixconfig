{
  pkgs,
  lib,
}:

pkgs.buildNpmPackage rec {
  pname = "fireconnect";
  version = "0.9.1";

  src = pkgs.fetchFromGitHub {
    owner = "fw-ai";
    repo = "fireconnect";
    rev = "df37b1264083c5b4f84e23b437a8cb844a053eed";
    hash = "sha256-dI3i6IXSY3gjxIcd7o9C5M7FggcMs7NQe8zDzqitt0s=";
  };

  sourceRoot = "${src.name}/packages/setup-cli";
  npmDepsHash = "sha256-PD3W8nqQTfx18EPF/fEBxoPdigwUaWtWxFs3vuOLrak=";
  dontNpmBuild = true;

  meta = {
    description = "Use Fireworks AI models in coding agents";
    homepage = "https://github.com/fw-ai/fireconnect";
    license = lib.licenses.asl20;
    mainProgram = "fireconnect";
  };
}
