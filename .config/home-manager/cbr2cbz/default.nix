{ stdenvNoCC
, lib
, unrar-free
, zip
, makeWrapper
}:

stdenvNoCC.mkDerivation rec {
  pname = "cbr2cbz";
  version = "1.0";
  src = ./.;

  buildInputs = [ unrar-free zip ];
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/script.sh $out/bin/cbr2cbz
    chmod +x $out/bin/cbr2cbz
    wrapProgram $out/bin/cbr2cbz \
      --prefix PATH : ${lib.makeBinPath [ unrar-free zip ]}
  '';
}
