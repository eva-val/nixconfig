{
  pkgs,
  lib,
  config,
  ...
}:

let
  pkgsX86 = import pkgs.path {
    localSystem = "x86_64-linux";
    inherit (config.nixpkgs) config;
  };

  inherit (pkgsX86) mesa;
  mesa32 = pkgsX86.pkgsi686Linux.mesa;

  # Upstream bambu-studio in nixpkgs is perpetually behind / broken; fetch the
  # vendor AppImage directly. Approach cribbed from the discourse thread at
  # https://discourse.nixos.org/t/bambu-studio-any-working-method/62272.
  bambu-studio = pkgsX86.appimageTools.wrapType2 rec {
    pname = "bambu-studio";
    version = "02.06.00.51";

    src = pkgsX86.fetchurl {
      url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/BambuStudio_ubuntu-24.04-v${version}-20260417160415.AppImage";
      hash = "sha256-CYePefJ7FXcAK+OXsIaNRHkml18BA7um4W2+f6l49zQ=";
    };

    profile = ''
      export SSL_CERT_FILE="${pkgsX86.cacert}/etc/ssl/certs/ca-bundle.crt"
      export GIO_MODULE_DIR="${pkgsX86.glib-networking}/lib/gio/modules/"
      # WebKit's dmabuf rendering path can't traverse the krun GPU
      # passthrough + FEX translation; force the legacy non-dmabuf path
      # or its embedded HTML views render as raw text.
      export WEBKIT_DISABLE_DMABUF_RENDERER=1
    '';

    # The network plugin (libbambu_networking.so) is downloaded to
    # ~/.config/BambuStudio/plugins/ on first run and dlopen'd by the main
    # binary. The AppImage bundles libs for its own components but NOT for
    # the runtime-downloaded plugin, so the FHS env needs the full set.
    # List mirrors nixpkgs' bambu-studio buildInputs.
    extraPkgs =
      pkgs: with pkgs; [
        cacert
        curl
        boost
        cereal
        dbus
        expat
        ffmpeg
        glew
        glfw
        glib
        glib-networking
        gmp
        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-good
        gtk3
        hicolor-icon-theme
        libpng
        mpfr
        nlopt
        opencv
        openssl
        pcre
        systemd
        webkitgtk_4_1
        wxwidgets_3_2
        libsoup_3
        libx11
      ];
  };

  initScript = pkgs.writeShellScript "muvm-bambu-init.sh" ''
    # Fix DNS: host's systemd-resolved stub (127.0.0.53) isn't reachable from the guest.
    echo 'nameserver 100.100.100.100' > /etc/resolv.conf
    echo 'nameserver 1.1.1.1' >> /etc/resolv.conf

    ln -snf ${mesa}   /run/opengl-driver
    ln -snf ${mesa32} /run/opengl-driver-32
  '';

  muvmBambu = pkgs.symlinkJoin {
    name = "muvm-${bambu-studio.name}";
    pname = "bambu-studio";
    inherit (bambu-studio) version;
    paths = [ bambu-studio ];
    postBuild = ''
      mv $out/bin/bambu-studio $out/bin/.bambu-studio-wrapped
      cat > $out/bin/bambu-studio <<EOF
      #!${pkgs.runtimeShell} -e
      exec ${lib.getExe pkgs.muvm} \\
        -x ${initScript} \\
        $out/bin/.bambu-studio-wrapped "\$@"
      EOF
      chmod +x $out/bin/bambu-studio
    '';
    meta = bambu-studio.meta // {
      description = "Bambu Studio AppImage, wrapped to run via muvm/FEX on Apple Silicon";
      platforms = [ "aarch64-linux" ];
      mainProgram = "bambu-studio";
    };
  };
in
{
  environment.systemPackages = [ muvmBambu ];
}
