{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "phpstorm-url-handler";
  version = "1.5.0";

  src = pkgs.fetchFromGitHub {
    owner = "sanduhrs";
    repo = pname;
    rev = version;
    sha256 = "Xg5nhE32hR9h5rkJj3cT1zSgsKZKeAfytgnoKuVIm94=";
  };

  installPhase = ''
    mkdir -p $out/bin $out/share/applications
    cp phpstorm-url-handler $out/bin
    cp phpstorm-url-handler.desktop $out/share/applications
  '';
}
