with import <nixpkgs> {};

let
  slides-src = ./slides;
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

  nativeBuildInputs = [ pandoc ];

  buildPhase = ''
    pandoc \
      --standalone \
      --incremental \
      --to revealjs \
      --metadata=revealjs-url:${revealjs-src} \
      --output index.html \
      *.md
  '';

  installPhase = ''
    mkdir $out
    cp index.html $out/
    ln -s ${img-src} $out/img
  '';
}
