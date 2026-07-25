{ muvmSupport }:

let
  inherit (muvmSupport) mkMuvmApp pkgsX86;

  # The nixpkgs package is frequently behind or broken; keep the vendor
  # AppImage pin here so updating it is isolated from host policy.
  bambuStudio = pkgsX86.appimageTools.wrapType2 rec {
    pname = "bambu-studio";
    version = "02.06.00.51";

    src = pkgsX86.fetchurl {
      url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/BambuStudio_ubuntu-24.04-v${version}-20260417160415.AppImage";
      hash = "sha256-CYePefJ7FXcAK+OXsIaNRHkml18BA7um4W2+f6l49zQ=";
    };

    profile = ''
      export SSL_CERT_FILE="${pkgsX86.cacert}/etc/ssl/certs/ca-bundle.crt"
      export GIO_MODULE_DIR="${pkgsX86.glib-networking}/lib/gio/modules/"
      export WEBKIT_DISABLE_DMABUF_RENDERER=1
    '';

    # The networking plug-in is downloaded at runtime and needs these
    # libraries available in the FHS environment.
    extraPkgs =
      x86: with x86; [
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
in
mkMuvmApp {
  package = bambuStudio;
  binaryName = "bambu-studio";
  pname = "muvm-bambu-studio";
  description = "Bambu Studio AppImage wrapped to run through muvm/FEX on Apple Silicon";
}
