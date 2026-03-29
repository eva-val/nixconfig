{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          meta = "layer(meta)";
          leftalt = "layer(alt)";
        };
        meta = {
          c = "C-c";
          v = "C-v";
          x = "C-x";
          a = "C-a";
          z = "C-z";
          s = "C-s";
          f = "C-f";
          w = "C-w";
          t = "C-t";
          r = "C-r";
          l = "C-l";
          q = "C-q";
          left = "home";
          right = "end";
        };
        alt = {
          left = "C-left";
          right = "C-right";
        };
      };
    };
  };
}
