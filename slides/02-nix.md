# Nix

# Nix?
- another package manager
- by Eelco Dolstra, part of his PhD research
- for Linux and MacOS

# Forget the FHS
- Nix introduces `/nix/store/`
    - read-only storage for packages
    - own environment for each package/version
    - created by build scripts
- `/nix/store/qi7n…qylyy-vim-8.0.1150`
    - hash is based on input and build script
    - new versions don't override, they coexist

# Nix Store
- package creates own `./etc`, `./bin`, …
    - references other objects in store
    - no side effects by other packages
- garbage collection cleans up

#
![](graphs/nix.png)

# Profiles
- environment with `$PATH`
- allows multiple profiles for different users
    - no need to restrict `/nix/store`-foo to root
- new generation after each change
    - switch, roll-back, delete

#
![[Source](https://nixos.org/nix/manual/#fig-user-environments)](img/user-environments.png)

#
```bash
$ nix-env -qaP firefox
nixos.firefox-esr          firefox-52.4.1esr
nixos.firefox-esr-wrapper  firefox-52.4.1esr
nixos.firefox              firefox-56.0.2
nixos.firefox-wrapper      firefox-56.0.2
nixos.firefoxWrapper       firefox-56.0.2

$ nix-env -iA nixos.firefox
. . .
building path(s) ‘/nix/store/izg…qvx-user-environment’
created 5550 symlinks in user environment
```

# Ad hoc packages
- sometimes no need to install a package
    - try a program, dependencies for a script
- `nix-shell` creates a temporary environment
    - install package in store, not in global environments
    - `nix-shell -p python36Packages.pillow`
- useable as a shebang

#
```python
#!/usr/bin/env nix-shell
#!nix-shell -p python36Packages.future python36Packages.pillow -i python

from builtins import str
from base64 import b64decode
from PIL import Image

. . .
```

#
```bash
#!/usr/bin/env nix-shell
#!nix-shell -p bc -i bc

x = 23
y = 42

x * y
```
