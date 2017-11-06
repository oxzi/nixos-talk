with import <nixpkgs> {};

let
  slides-src = ./slides;
  graphs-src = ./graphs;
  img-src = ./img;

  revealjs-src = fetchFromGitHub {
    owner = "hakimel";
    repo = "reveal.js";
    rev = "3.5.0";
    sha256 = "0aj6y16d2wnncmamlqzimcnh56q755h62jw1g0i05ik79l97175w";
  };
in stdenv.mkDerivation {
  name = "nixos-talk";
  src = slides-src;

  nativeBuildInputs = [ graphviz pandoc ];

  buildPhase = ''
    mkdir graphs
    for f in ${graphs-src}/*.dot; do
      dot -Tpng $f > graphs/`basename $f .dot`.png
    done

    pandoc \
      --standalone \
      --incremental \
      --to revealjs \
      --variable=controls:false \
      --variable=theme:white \
      --output index.html \
      *.md
  '';

  installPhase = ''
    mkdir $out
    cp index.html $out/
    cp -r graphs/ $out/
    cp -r ${img-src} $out/img
    cp -r ${revealjs-src} $out/reveal.js
  '';
}
