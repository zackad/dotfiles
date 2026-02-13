{
  stdenvNoCC,
  lib,
  writeShellScript,
  config,
  curl,
  playerctl,
}:

stdenvNoCC.mkDerivation rec {
  pname = "media-control";
  version = "1.0.0";
  src = ./.;

  # Use writeScript to create the script
  script = writeShellScript "media-control" ''
    # The command to send to Plexamp
    PLEX_PORT=32500
    ACTION=$1 # play-pause, next, or previous

    # Map playerctl actions to Plexamp API endpoints
    case $ACTION in
      play-pause) PLEX_CMD="playPause" ;;
      next)       PLEX_CMD="skipNext" ;;
      previous)   PLEX_CMD="skipPrevious" ;;
    esac

    # If a player (like Firefox/Chrome) is active, use playerctl
    ${playerctl}/bin/playerctl "$ACTION"

    # Otherwise, fallback to Plexamp API
    ${curl}/bin/curl "http://127.0.0.1:$PLEX_PORT/player/playback/$PLEX_CMD"
  '';

  # The script is already executable, so we don't need to set permissions
  installPhase = ''
    mkdir -p $out/bin
    cp ${script} $out/bin/media-control
  '';

  meta = with lib; {
    description = "Wrapper to control media key action";
    license = licenses.mit;
  };
}
