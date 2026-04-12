{
  pkgs,
  lib,
  ...
}:

let
  # Google ships Android Studio for Linux as x86_64 only. We repackage it
  # for native aarch64 by swapping the bundled x86_64 JetBrains Runtime for
  # nixpkgs' aarch64 JBR-JCEF and replacing the JNA native library. The
  # remaining x86_64 bits (fsnotifier, restarter, libskiko, libpty) run via
  # the qemu-user binfmt registered in modules/fex.nix — slower than native
  # but functional. SDK CLI tools (adb, aapt2, emulator, …) are likewise
  # x86_64 and rely on the same binfmt at runtime.
  version = "2025.3.3.6";

  src = pkgs.fetchurl {
    url = "https://edgedl.me.gvt1.com/android/studio/ide-zips/${version}/android-studio-panda3-linux.tar.gz";
    hash = "sha256-NBrA/BfbyYfQUw4M+zJxJUgFM9ZzOoifITdja+zUhqU=";
  };

  jbr = pkgs.jetbrains.jdk;

  # Tools the IDE shells out to (matches the FHS env in nixpkgs'
  # x86_64 android-studio derivation, minus the x86-only bits).
  runtimePath = lib.makeBinPath (
    with pkgs;
    [
      git
      coreutils
      which
      gnused
      gnugrep
      gawk
    ]
  );

  android-studio-aarch64 = pkgs.stdenv.mkDerivation {
    pname = "android-studio-aarch64";
    inherit version src;

    nativeBuildInputs = with pkgs; [
      makeWrapper
      unzip
    ];

    dontPatchELF = true;
    dontStrip = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/libexec/android-studio
      cp -r . $out/libexec/android-studio
      chmod -R u+w $out/libexec/android-studio

      # Drop the bundled x86_64 JBR; symlink the aarch64 JBR-JCEF from
      # nixpkgs. studio.sh checks $IDE_HOME/jbr/release for the host arch
      # before using it, and the nixpkgs jetbrains.jdk release file
      # advertises aarch64 so this passes.
      rm -rf $out/libexec/android-studio/jbr
      ln -s ${jbr} $out/libexec/android-studio/jbr

      # Replace the JNA native dispatch library. The bundled jar at
      # lib/jna/amd64/libjnidispatch.so is x86_64; the nixpkgs jna jar is
      # a fat jar with com/sun/jna/linux-aarch64/libjnidispatch.so inside.
      mkdir -p $out/libexec/android-studio/lib/jna/aarch64
      unzip -p ${pkgs.jna}/share/java/jna.jar \
        com/sun/jna/linux-aarch64/libjnidispatch.so \
        > $out/libexec/android-studio/lib/jna/aarch64/libjnidispatch.so

      # Wrapper. studio.sh prefers $STUDIO_JDK over $IDE_HOME/jbr, so we
      # set both belt-and-braces. -Djna.boot.library.path tells JNA to
      # load libjnidispatch from our aarch64 directory before consulting
      # the bundled jar.
      mkdir -p $out/bin
      makeWrapper $out/libexec/android-studio/bin/studio.sh $out/bin/android-studio \
        --set STUDIO_JDK ${jbr} \
        --set JAVA_HOME ${jbr} \
        --set _JAVA_OPTIONS "-Djna.boot.library.path=$out/libexec/android-studio/lib/jna/aarch64 -Djna.nosys=true" \
        --prefix PATH : ${runtimePath}

      # Desktop entry so COSMIC's launcher picks it up.
      mkdir -p $out/share/applications $out/share/pixmaps
      cp $out/libexec/android-studio/bin/studio.svg $out/share/pixmaps/android-studio.svg
      cat > $out/share/applications/android-studio.desktop <<EOF
      [Desktop Entry]
      Type=Application
      Name=Android Studio
      Comment=Android IDE (native aarch64 repack)
      Exec=$out/bin/android-studio %f
      Icon=android-studio
      Terminal=false
      Categories=Development;IDE;
      StartupWMClass=jetbrains-studio
      EOF

      runHook postInstall
    '';

    meta = {
      description = "Android Studio repackaged with aarch64 JBR for Asahi";
      homepage = "https://developer.android.com/studio";
      license = lib.licenses.asl20;
      platforms = [ "aarch64-linux" ];
      mainProgram = "android-studio";
    };
  };
in
{
  # android-tools provides adb/fastboot on $PATH outside the SDK install.
  # systemd 258+ handles device uaccess automatically, so no extra
  # udev/group setup is needed for talking to physical devices.
  environment.systemPackages = [
    android-studio-aarch64
    pkgs.android-tools
  ];
}
