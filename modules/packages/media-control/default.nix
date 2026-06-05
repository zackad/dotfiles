{
  perSystem =
    { pkgs, ... }:
    {
      packages.media-control = pkgs.writeShellApplication {
        name = "media-control";

        # Use writeScript to create the script
        text = ''
          # The command to send to Plexamp
          # PLEX_PORT=32500
          ACTION=$1 # play-pause, next, or previous

          # Map playerctl actions to Plexamp API endpoints
          # case $ACTION in
          #   play-pause) PLEX_CMD="playPause" ;;
          #   next)       PLEX_CMD="skipNext" ;;
          #   previous)   PLEX_CMD="skipPrevious" ;;
          # esac

          # If a player (like Firefox/Chrome) is active, use playerctl
          ${pkgs.playerctl}/bin/playerctl "$ACTION"

          # Otherwise, fallback to Plexamp API
          # ${pkgs.curl}/bin/curl "http://127.0.0.1:$PLEX_PORT/player/playback/$PLEX_CMD"
        '';
      };
    };
}
