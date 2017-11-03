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

# Difficulties
- unclear dependencies
    - preinstalled libs, side effects
- two packages want to create the same file
    - abort or override
    - multiple versions of the same program
- configuration files
    - override, synchronize, uninstall

# Problems

#
![](img/arch-mom-pacman-fucked-xorg-again.png)
