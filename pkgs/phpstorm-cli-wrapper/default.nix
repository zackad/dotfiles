{
  stdenvNoCC,
  lib,
  writeShellScript,
  config,
}:

stdenvNoCC.mkDerivation rec {
  pname = "phpstorm-cli-wrapper";
  version = "0.2.0";
  src = ./.;

  # Use writeScript to create the script
  script =
    if lib.hasAttr "boot" config then
      # Using steam-run to run phpstorm that manually installed (not from nixpkgs)
      writeShellScript "pstorm" ''
        steam-run $HOME/Applications/PhpStorm/bin/phpstorm "$@" > /dev/null 2>&1 & disown
      ''
    else
      # For regular linux distro, assuming you have added phpstorm cli launcher into your PATH
      writeShellScript "pstorm" ''
        phpstorm "$@" > /dev/null 2>&1 & disown
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
