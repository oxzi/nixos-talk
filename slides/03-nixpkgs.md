# Nixpkgs

# Packages
- Nix expression language
- GitHub repository
    - branches for channels
    - PRs for updated/new packages

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

# Phases
- unpack, patch, configure, build, install, fixup, dist
    - pre and post phases
- can be extended or overridden
    - arguments for phases or make, cmake, …
    - Bash scripting
