{ lib, pkgs }:

let
  pkgsX86 = import pkgs.path {
    localSystem = "x86_64-linux";
    inherit (pkgs) config;
  };

  initScript = pkgs.writeShellScript "muvm-app-init.sh" ''
    # The host's systemd-resolved stub is unreachable from the guest.
    echo 'nameserver 100.100.100.100' > /etc/resolv.conf
    echo 'nameserver 1.1.1.1' >> /etc/resolv.conf

    ln -snf ${pkgsX86.mesa} /run/opengl-driver
    ln -snf ${pkgsX86.pkgsi686Linux.mesa} /run/opengl-driver-32
  '';

  mkMuvmApp =
    {
      package,
      binaryName,
      pname,
      description,
      extraMuvmArgs ? [ ],
    }:
    pkgs.symlinkJoin {
      name = "${pname}-${package.version}";
      inherit pname;
      inherit (package) version;
      paths = [ package ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        mv $out/bin/${binaryName} $out/bin/.${binaryName}-wrapped
        makeWrapper ${lib.getExe pkgs.muvm} $out/bin/${binaryName} \
          --add-flags -x \
          --add-flags ${initScript} \
          ${
            lib.concatMapStringsSep " \\\n          " (
              arg: "--add-flags ${lib.escapeShellArg arg}"
            ) extraMuvmArgs
          } \
          --add-flags $out/bin/.${binaryName}-wrapped
      '';
      meta = package.meta // {
        inherit description;
        platforms = [ "aarch64-linux" ];
        mainProgram = binaryName;
      };
    };
in
{
  inherit mkMuvmApp pkgsX86;
}
