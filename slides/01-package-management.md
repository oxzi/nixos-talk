# Package managment

# Why?
- deploying software
- up- and downgrades
- manage libraries in different versions

# How?
- modification of the state
    -  current filesystem
    -  build script
    - $\to$ modified filesystem

#
![](graphs/package-manager.png)

# Difficulties
- unclear dependencies
    - preinstalled libs, side effects
- different packages requires the same path
    - Filesystem Hierarchy Standard
    - multiple versions of the same program

# Difficulties
- configuration files
    - override, synchronize, uninstall
- monkey patches

# Difficulties
- missing roll back-features
    - testing alternative software
- power/system failure
    - still atomic?

#
![](img/arch-mom-pacman-fucked-xorg-again.png)
