{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "witchhazel";

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

    themes = {
      witchhazel = {
        "ui.background" = {
          bg = "background";
        };
        "ui.text" = "bone";

        "ui.cursor" = {
          bg = "bone";
          fg = "background";
        };
        "ui.cursor.normal" = {
          bg = "bone";
          fg = "background";
        };
        "ui.cursor.insert" = {
          bg = "mint";
        };
        "ui.cursor.match" = "turquoise";
        "ui.selection" = {
          bg = "amethyst";
        };

        "ui.menu" = {
          bg = "panel";
          fg = "bone";
        };
        "ui.menu.selected" = {
          bg = "highlight";
        };
        "ui.help" = {
          bg = "panel";
          fg = "cloud";
        };
        "ui.popup" = {
          bg = "panel";
          fg = "cloud";
        };
        "ui.highlight" = {
          bg = "background";
          fg = "bone";
        };

        "ui.cursorline.primary" = {
          bg = "panel";
        };
        "ui.cursorcolumn.primary" = {
          bg = "panel";
        };
        "ui.cursorline.secondary" = {
          bg = "background";
        };
        "ui.cursorcolumn.secondary" = {
          bg = "background";
        };

        "ui.statusline" = {
          bg = "highlight";
          fg = "bone";
        };
        "ui.statusline.normal" = {
          bg = "highlight";
          fg = "bone";
        };
        "ui.statusline.insert" = {
          bg = "mint";
          fg = "panel";
        };
        "ui.statusline.select" = {
          modifiers = [ "reversed" ];
        };
        "ui.gutter" = "stone";
        "ui.gutter.selected" = {
          bg = "background";
          fg = "smoke";
        };

        "ui.virtual" = "stone";
        "ui.virtual.ruler" = {
          bg = "panel";
        };

        "hint" = "mint";
        "info" = "daffodil";
        "warning" = "turquoise";
        "error" = "salmon";
        "diagnostic" = {
          bg = "background";
        };
        "diagnostic.hint" = {
          underline = {
            color = "mint";
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = "daffodil";
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = "turquoise";
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = "salmon";
            style = "curl";
          };
        };

        "comment" = "smoke";
        "string" = "turquoise";
        "constant" = {
          fg = "lilac";
          modifiers = [ "bold" ];
        };
        "keyword" = "mint";
        "keyword.storage.type" = {
          fg = "mint";
          modifiers = [ "italic" ];
        };
        "keyword.storage.modifier" = {
          fg = "teal";
          modifiers = [
            "bold"
            "italic"
          ];
        };
        "type" = "bone";
        "type.builtin" = {
          fg = "turquoise";
          modifiers = [ "italic" ];
        };
        "function" = "aster";
        "variable" = "bone";
        "variable.parameter" = {
          fg = "salmon";
          modifiers = [ "italic" ];
        };
        "tag" = "peony";
        "attribute" = "daffodil";
        "constructor" = "iceblue";

        "markup.heading" = "daffodil";
        "markup.link.url" = {
          fg = "mint";
          modifiers = [ "bold" ];
        };
        "markup.raw" = "daffodil";

        "diff.plus" = "mint";
        "diff.minus" = "peony";
        "diff.delta" = "turquoise";

        palette = {
          background = "#282634";
          panel = "#131218";
          highlight = "#8864cb";
          bone = "#f8f8f2";
          cloud = "#c6c4cc";
          smoke = "#bfbfbf";
          stone = "#8a8a8a";
          turquoise = "#81eeff";
          lilac = "#c5a3ff";
          aster = "#dcc8ff";
          mint = "#81ffbe";
          daffodil = "#fff9a3";
          salmon = "#ffa3c3";
          peony = "#ffb8d1";
          amethyst = "#8077a8";
          teal = "#64becb";
          iceblue = "#a3f3ff";
        };
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
