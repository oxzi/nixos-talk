{ pkgs ? import <nixpkgs> {} }:

let
  revealjs-version = "3.5.0";
in pkgs.stdenv.mkDerivation {
  name = "nixos-talk";
  src = ./.;

  nativeBuildInputs = with pkgs; [ git pandoc ];

  patchPhase = ''
    cd reveal.js/
    git checkout ${revealjs-version}
    cd ..
  '';

  buildPhase = ''
    pandoc \
      --standalone \
      --incremental \
      --to revealjs \
      --output index.html \
      slides/*.md
  '';

  installPhase = ''
    mkdir $out
    cp index.html $out/
    cp -r img $out/
    cp -r reveal.js $out/
  '';
}
