# Nixpkgs

# Packages
- Nix expression language
- GitHub repository
    - branches for channels
    - PRs for updated/new packages

# Phases
- unpack, patch, configure, build, install, fixup, dist
    - pre and post phases
- can be extended or overridden
    - arguments for phases or make, cmake, …
    - Bash scripting

#
```nix
{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "hello-2.10";

  src = fetchurl  {
    url    = "https://ftp.gnu.org/gnu/…/hello-2.10.tar.gz";
    sha256 = "1im1grv. . . .mzljq75";
  };

  doCheck = true;

  meta = { … };
}
```

#
```nix
{ stdenv, lib, writeText, buildPythonPackage,
  fetchPypi, isPy3k, libpcap, dpkt }:

buildPythonPackage rec {
  pname = "pypcap";
  version = "1.1.6";
  name = "${pname}-${version}";
  disabled = isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1cx7qm. . .a33syi";
  };

  patches = [
    (writeText "libpcap-path.patch" ''
       def get_extension():
           # A list of all the possible search directories
      -    dirs = ['/usr', sys.prefix] + \
      +    dirs = ['${libpcap}', '/usr', sys.prefix] + \
      '')
  ];

  buildInputs = [ libpcap dpkt ];

  meta = { … };
}
```

# Build system
- can be used outside of nixpkgs
- `nix-build`
    - build script in Nix expression
    - stores result in the Nix store
- can be installed with `nix-env`

#
```nix
{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  name = "et";
  src = ./.;

  buildInputs = with pkgs; [ libnotify gdk_pixbuf ];
  nativeBuildInputs = [ pkgs.pkgconfig ];

  installPhase = ''
    mkdir -p $out/bin
    cp et $out/bin
    cp et-status.sh $out/bin/et-status
  '';
}
```

#
```
$ nix-build
these derivations will be built:
  /nix/store/d1lrjldnik6ycqra63ddyvi6rk5hmavd-et.drv
. . . 
/nix/store/jq4hmsmwf6bxl4hfm3p9ss2y412wr72m-et
$ ls -l result
lrwxrwxrwx . . . result -> /nix/store/jq4hm…412wr72m-et/
$ find result/
result/
result/bin
result/bin/et
result/bin/et-status
```
