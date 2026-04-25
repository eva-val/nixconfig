{ pkgs, ... }:

{
  # PipeWire tuning for Asahi speaker DSP
  services.pipewire.extraConfig.pipewire."91-asahi-quantum" = {
    "context.properties" = {
      "default.clock.quantum" = 1024;
      "default.clock.min-quantum" = 512;
      "default.clock.max-quantum" = 2048;
    };
  };

  # On fresh boot the asahi-audio filter-chain sink comes up at full volume
  # because wireplumber's restore-stream doesn't apply the saved value to
  # virtual filter-chain sinks reliably. Parse wireplumber's stream-properties
  # ourselves and push the saved volume onto the default sink after session
  # start — this keeps the speakers from blasting at boot.
  systemd.user.services.asahi-audio-volume-restore = {
    description = "Restore wireplumber-saved volume onto the default sink at login";
    wantedBy = [ "default.target" ];
    after = [
      "wireplumber.service"
      "pipewire.service"
    ];
    requires = [ "wireplumber.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "asahi-volume-restore" ''
        set -eu
        PATH=${pkgs.wireplumber}/bin:${pkgs.gawk}/bin:${pkgs.gnused}/bin:${pkgs.coreutils}/bin

        for _ in $(seq 1 40); do
          if wpctl get-volume @DEFAULT_AUDIO_SINK@ >/dev/null 2>&1; then break; fi
          sleep 0.25
        done

        media_name=$(wpctl inspect @DEFAULT_AUDIO_SINK@ 2>/dev/null \
          | awk -F'"' '/media\.name = /{print $2; exit}')
        [ -n "''${media_name:-}" ] || exit 0

        # Wireplumber escapes key chars in saved state: space->\s ( -> \o ) -> \c.
        escaped=$(printf '%s' "$media_name" \
          | sed -e 's/\\/\\\\/g' -e 's/ /\\s/g' -e 's/(/\\o/g' -e 's/)/\\c/g')
        prefix="Audio/Sink:media.name:''${escaped}="

        state="''${XDG_STATE_HOME:-$HOME/.local/state}/wireplumber/stream-properties"
        [ -f "$state" ] || exit 0

        line=""
        while IFS= read -r l; do
          case "$l" in "$prefix"*) line=$l; break;; esac
        done < "$state"
        [ -n "$line" ] || exit 0

        vol=$(printf '%s' "$line" | sed -n 's/.*"channelVolumes":\[\([0-9.]*\).*/\1/p')
        [ -n "$vol" ] || exit 0

        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$vol"
      '';
    };
  };
}
