{
  stdenvNoCC,
  lib,
  writeShellScript,
}:

stdenvNoCC.mkDerivation rec {
  pname = "phpstorm-cli-wrapper";
  version = "0.2.0";
  src = ./.;

  # Use writeScript to create the script
  script = writeShellScript "pstorm" ''
    steam-run $HOME/Applications/PhpStorm/bin/phpstorm "$@" > /dev/null 2>&1 & disown
  '';

  # The script is already executable, so we don't need to set permissions
  installPhase = ''
    mkdir -p $out/bin
    cp ${script} $out/bin/pstorm
  '';

  meta = with lib; {
    description = "Wrapper launcher for phpstorm from cli";
    license = licenses.mit;
  };
}
