# NixOS

# Nix as an OS
- GNU/Linux distribution
- declarative system configuration
    - based on Nix and Nixpkgs
    - reliable upgrades
    - atomic upgrades
    - rollbacks

#
```bash
# create partiotions and mount your system to /mnt
nixos-generate-config --root /mnt
vi /mnt/etc/nixos/configuration.nix
```

#
```nix
{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.device = "/dev/sda";

  services.sshd.enable = true;

  users.extraUser.alvar = {
    name = "alvar";
    group = "users";
    extraGroups = [ "wheel" "systemd-journal" ];
  };
}

```

#
```bash
nixos-install
reboot
```
