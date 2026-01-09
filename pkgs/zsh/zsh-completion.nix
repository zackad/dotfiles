{ pkgs, stdenv, ... }:

stdenv.mkDerivation {
  pname = "my-custom-zsh-completions";
  version = "1.0";

  # Source your completion files from a directory, e.g., 'completions'
  # If your completion files are in the same directory as this Nix file,
  # you can use ./ to refer to it.
  src = ./completions;

  # Or, if you only have one file:
  # src = ./_myprogram;

  # The Zsh completion system looks in $out/share/zsh/site-functions
  # for completion functions (which usually start with an underscore, e.g., _myprogram).
  installPhase = ''
    mkdir -p $out/share/zsh/site-functions
    cp _symfony-console $out/share/zsh/site-functions/
  '';

  # Ensure the completion script is executable if it contains shell code,
  # but for simple Zsh functions, read permission is enough.
}
