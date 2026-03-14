{ pkgs, ... }:

let
  witchHazel = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "witch-hazel";
    publisher = "theaflowers";
    version = "2024.5.21";
    sha256 = "1aqwn0y8dkmd4lmrji176204cqmqxisyr6jkpbz9blim7pnw5vdk";
  };
in
{
  programs.vscode = {
    enable = true;

    extensions =
      with pkgs.vscode-extensions;
      [
        jnoortheen.nix-ide
        mkhl.direnv
        editorconfig.editorconfig
        rust-lang.rust-analyzer
      ]
      ++ [ witchHazel ];

    userSettings = {
      "workbench.colorTheme" = "Witch Hazel";

      "editor.fontSize" = 14;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.formatOnSave" = true;
      "editor.renderWhitespace" = "trailing";

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        nil = {
          formatting = {
            command = [ "nixfmt" ];
          };
        };
      };

      "files.associations" = {
        "*.nix" = "nix";
        "flake.lock" = "json";
      };

      "terminal.integrated.defaultProfile.linux" = "fish";

      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
    };
  };
}
