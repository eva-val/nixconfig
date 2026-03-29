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

    # Based on https://github.com/theacodes/witchhazel/blob/main/helix/witchhazel_hyper.toml
    themes = {
      witchhazel = {
        "ui.background" = {
          bg = "iris";
        };
        "ui.text" = "bone";

        "ui.cursor" = {
          bg = "bone";
          fg = "gloom";
        };
        "ui.cursor.normal" = {
          bg = "bone";
          fg = "gloom";
        };
        "ui.cursor.insert" = {
          bg = "fern";
        };
        "ui.cursor.match" = "carolina";
        "ui.selection" = {
          bg = "nightshade";
        };

        "ui.menu" = {
          bg = "purple";
          fg = "cloud";
        };
        "ui.menu.selected" = {
          bg = "scum";
          fg = "gloom";
        };
        "ui.help" = {
          bg = "purple";
          fg = "cloud";
        };
        "ui.popup" = {
          bg = "purple";
          fg = "cloud";
        };
        "ui.window" = {
          bg = "purple";
          fg = "cloud";
        };
        "ui.highlight" = {
          bg = "iris";
          fg = "bone";
        };

        "ui.cursorline.primary" = {
          bg = "gloom";
        };
        "ui.cursorcolumn.primary" = {
          bg = "gloom";
        };
        "ui.cursorline.secondary" = {
          bg = "smoke";
        };
        "ui.cursorcolumn.secondary" = {
          bg = "smoke";
        };

        "ui.statusline" = {
          bg = "thistle";
          fg = "bone";
        };
        "ui.statusline.normal" = {
          bg = "thistle";
          fg = "bone";
        };
        "ui.statusline.insert" = {
          bg = "fern";
          fg = "gloom";
        };
        "ui.statusline.select" = {
          modifiers = [ "reversed" ];
        };
        "ui.gutter" = "stone";
        "ui.gutter.selected" = {
          bg = "gloom";
          fg = "cloud";
        };

        "ui.virtual" = "stone";
        "ui.virtual.ruler" = {
          bg = "gloom";
        };

        "hint" = "fern";
        "info" = "scotchbroom";
        "warning" = "carolina";
        "error" = "peony";
        "diagnostic" = {
          bg = "iris";
        };
        "diagnostic.hint" = {
          underline = {
            color = "fern";
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = "scotchbroom";
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = "carolina";
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = "peony";
            style = "curl";
          };
        };

        "comment" = "smoke";
        "string" = "carolina";
        "constant" = {
          fg = "aster";
          modifiers = [ "bold" ];
        };
        "constant.numeric" = "scotchbroom";
        "keyword" = "fern";
        "keyword.storage.type" = {
          fg = "fern";
          modifiers = [ "italic" ];
        };
        "keyword.storage.modifier" = {
          fg = "sound";
          modifiers = [ "italic" ];
        };
        "type.builtin" = "fern";
        "function" = "aster";
        "variable" = "bone";
        "variable.parameter" = "peony";
        "tag" = "peony";
        "attribute" = "scotchbroom";
        "punctuation.delimiter" = "fern";
        "operator" = "fern";

        "markup.heading" = "scotchbroom";
        "markup.link.url" = {
          fg = "fern";
          modifiers = [ "bold" ];
        };
        "markup.raw" = "scotchbroom";

        "diff.plus" = "fern";
        "diff.minus" = "peony";
        "diff.delta" = "carolina";

        palette = {
          gloom = "#131218";
          iris = "#282634";
          purple = "#433e56";
          nightshade = "#8077a8";
          thistle = "#8864cb";
          aster = "#c5a3ff";
          stone = "#8a8a8a";
          smoke = "#bfbfbf";
          cloud = "#c6c4cc";
          bone = "#f8f8f0";
          scum = "#64cb96";
          fern = "#81ffbe";
          sound = "#46becb";
          carolina = "#81eeff";
          scotchbroom = "#fff9a3";
          peony = "#ffb8d1";
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
