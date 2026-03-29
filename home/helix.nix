{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        line-number = "relative";
        cursorline = true;
        auto-save.after-delay.enable = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        lsp.display-inlay-hints = true;
        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-type"
          ];
        };
        soft-wrap.enable = true;
      };
    };

    languages = {
      language-server = {
        nil.command = "${pkgs.nil}/bin/nil";
        pyright.command = "${pkgs.pyright}/bin/pyright-langserver";
        ruff.command = "${pkgs.ruff}/bin/ruff";
        jdtls.command = "${pkgs.jdt-language-server}/bin/jdtls";
        rust-analyzer.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
      };

      language = [
        {
          name = "nix";
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
          auto-format = true;
          language-servers = [ "nil" ];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "pyright"
            "ruff"
          ];
        }
        {
          name = "java";
          auto-format = true;
          language-servers = [ "jdtls" ];
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = [ "rust-analyzer" ];
        }
      ];
    };
  };
}
