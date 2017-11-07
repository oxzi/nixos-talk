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

# configuration.nix
- `configuration.nix` in Nix expression
- services described in modules
    - `services.tor.enable = true;`
- `nixos-rebuild switch`

# nixos-rebuild
- `build`: generate new generation
- `switch`: new generation and switch
- `boot`: new generation after boot
- `test`: switch, but don't `boot`
- `build-vm`: QEMU-VM for new generation
- `--rollback`: roll back to previous configuration

#
![[Source](https://nixos.org/nixos/about.html)](img/nixos-grub.png)

#
```nix
services.nginx = {
  enable = true;
  virtualHosts."example.com" = {
    forceSSL = true;
    enableACME = true;
    locations = {
      "/" = {
        root = "/var/www";
        index = "index.php";
      };
      "/api/".proxyPass = http://localhost:2323;
    };
  };
};
```

# Containers
- systemd-nspawn based containers
- isolate service to a namespace container
- own IP address or NAT
- per default no internet access

#
```nix
containers.webserver = {
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.11";

  config = { config, pkgs, ... }: {
    services.httpd = {
      enable = true;
      documentRoot = "/webroot";
    };
  };
};
```

# That's it!
