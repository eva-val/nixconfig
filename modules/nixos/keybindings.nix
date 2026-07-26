_:

{
  # keyd grabs the physical keyboard and exposes a virtual one. Mark that
  # replacement as internal so libinput's disable-while-typing logic can pair
  # it with the built-in touchpad.
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Keyd Virtual Keyboard]
    MatchUdevType=keyboard
    MatchName=keyd*keyboard
    AttrKeyboardIntegration=internal
  '';

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
