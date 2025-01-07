# NixBox

A minimal starting setup for NixOS.

## Features

- WM with hyprland 
- Really Blazing Fast neovim by Nixvim
  - no lazy loading
  - no plugin manager
  - ~Ironically those above claims to be the source of efficiency but they turn out to be the reason of slowness from my experience~
  - benchmarked with a pair of 140Hz detectable human eyes and a pair of hands around 90 WPM. 
- consistent theme with flavors to choose across OS by Catppuccin. 
- a lot of git alias (sorry for injecting opininated aliases, I'll fix this if yall don't like them)
- and more...

> [!WARNING]
> Still in alpha version, expecting bugs


## Install

Clone the repo, create a config directory for nix and copy the content of the example to it
```sh
git clone git@github.com:AstrickHarren/nixbox.git
mkdir -p ~/.config/nix
cp nixbox/example/* ~/.config/nix
```

Copy the your NixOS hardware configuration to the config directory as well, it can be done usually by
```sh
cp /etc/nixos/hardware-configuration.nix hardware.nix
```

> [!IMPORTANT]
> Make sure you read the example thoroughly and change config accordingly before the next step!
> There are plently of places you might want to change, most obviously the userName and hostName

## Build

Now you are good to go! Run the following commands to build your NixOS and home manager!

```sh
sudo nixos-rebuild switch --flake ~/.config/nix 
home-manager switch --flake ~/.config/nix
```

## Update

If there is a change made to NixBox, you can update your subscription by running
```sh
nix flake update nixbox
```
under `~/.config/nix`. This will update you to the newest version of NixBox and any 
dependency of NixBox. Rebuild your NixOS and/or home manager and you'll see the effect.
