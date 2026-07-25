_final: prev: {
  # nixpkgs patches the udev rule but does not install it. Remove this overlay
  # once pkgs/by-name/wl/wluma installs 90-wluma-backlight.rules upstream.
  wluma = prev.wluma.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      install -Dm644 90-wluma-backlight.rules \
        $out/lib/udev/rules.d/90-wluma-backlight.rules
    '';
  });
}
