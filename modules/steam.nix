{
  pkgs,
  lib,
  config,
  ...
}:

let
  pkgsX86 = import pkgs.path {
    system = "x86_64-linux";
    inherit (config.nixpkgs) config;
  };

  inherit (pkgsX86) mesa;
  mesa32 = pkgsX86.pkgsi686Linux.mesa;
  steam = pkgsX86.steam;

  initScript = pkgs.writeShellScript "muvm-steam-init.sh" ''
    # Fix DNS: host's systemd-resolved stub (127.0.0.53) isn't reachable from the guest.
    # Use Tailscale's MagicDNS (handles .ts.net + forwards the rest) with Cloudflare fallback.
    echo 'nameserver 100.100.100.100' > /etc/resolv.conf
    echo 'nameserver 1.1.1.1' >> /etc/resolv.conf

    ln -snf ${mesa}   /run/opengl-driver
    ln -snf ${mesa32} /run/opengl-driver-32
  '';

  pulseConf = pkgs.writeText "pulse.conf" ''
    enable-shm=no
  '';

  muvmSteam = pkgs.symlinkJoin {
    name = "muvm-${steam.name}";
    pname = steam.pname;
    version = steam.version;
    paths = [ steam ];
    postBuild = ''
      mv $out/bin/steam $out/bin/.steam-wrapped
      cat > $out/bin/steam <<EOF
      #!${pkgs.runtimeShell} -e
      exec ${lib.getExe pkgs.muvm} \\
        -x ${initScript} \\
        -e PULSE_CLIENTCONFIG=${pulseConf} \\
        $out/bin/.steam-wrapped "\$@"
      EOF
      chmod +x $out/bin/steam
    '';
    meta = steam.meta // {
      description = "Steam, wrapped to run via muvm/FEX on Apple Silicon";
      platforms = [ "aarch64-linux" ];
      mainProgram = "steam";
    };
  };
in
{
  environment.systemPackages = [ muvmSteam ];
}
