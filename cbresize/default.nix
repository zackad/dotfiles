{
  stdenvNoCC,
  lib,
  writeShellScript,
  imagemagick,
  parallel,
  unzip,
  zip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "cbresize";
  version = "0.2.0";
  src = ./.;

  # Use writeScript to create the script
  script = writeShellScript "cbresize" ''
    # get input file
    input=$1
    basename=$(basename "$input")
    result=$(pwd)/$basename
    echo $input
    echo $basename
    echo $result

    # create temporary directory to store extracted images
    tmpdir=$(mktemp --directory)
    echo $tmpdir

    # extract images into temporary directory
    unzip -j -d $tmpdir "$input"

    # resize images with imagemagick
    ${parallel}/bin/parallel mogrify -resize x1600 -quality 100 ::: $tmpdir/*

    # package images into comicbook
    zip "$result" -j -r $tmpdir
    echo $result

    # cleanup
    rm -fr $tmpdir
  '';

  # The script is already executable, so we don't need to set permissions
  installPhase = ''
    mkdir -p $out/bin
    cp ${script} $out/bin/cbresize
  '';

  meta = with lib; {
    description = "Resize comicbook to save space";
    license = licenses.mit;
  };
}
