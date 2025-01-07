# Minix

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

Create a folder in the place `~/.config/nix` with the following structure
```
~/.config/nix
├── flake.nix
├── hardware.nix
└── home.nix
```

Copy your hardware configuration from `/etc/nixos/hardware-configuration.nix`
```bash
cp /etc/nixos/hardware-configuration.nix hardware.nix
```

Add the following content to `flake.nix`

> [!IMPORTANT]
> Make sure to change the `settings` field in the file for your purpose

```nix
# flake.nix

{
  inputs = {
    minix.url = "github:AstrickHarren/minix";
  };

  outputs = inputs: inputs.minix.mkMinix {
      inherit inputs;
      settings = 
        {
          userName = "YOUR_USERNAME"; # change this
          hostName = "YOUR_HOSTNAME"; # and this
          hardware = ./hardware.nix;
          home = ./home.nix;

          # Select your boot method. 
          # You will typically use uefi (MS secure boot) for dual boot
          boot.loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            # This is selected by you when you installed NixOS
            efi.efiSysMountPoint = "/boot";
            grub.useOSProber = true;
          };

          # Alternatively, you will boot with grub
          # boot.loader.grub.enable = true;
          # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

          # If you want to install nvidia driver, usually required if your 
          # laptop doesn't have a second GPU
          nvidiaDriver.enable = true;
          # If you are using an outdated nvidia GPU, consider using a legacy 
          # driver instead. For example, 
          # nvidiaDriver.version = "legacy_470"
         
          # Install rootLESS! docker, unfortunately, rootFUL doocker is not
          # supported by Minix. Docker data is put in `~/.cache`
          dockerRootless.enable = true;

          system = "x86_64-linux";
          stateVersion = "24.11";
        }
    };
}
```

Add the `home.nix` file from `example/` and please **read it thoroughly**, it's couple of lines long
This is where nix home manager come into play. To find all the options you can 
put here, refer to [nix home manager options](https://nix-community.github.io/home-manager/options.xhtml).

Now you are good to go! Run the following commands to build your NixOS and
home manager! 

```sh
sudo nixos-rebuild switch --flake ~/.config/nix 
home-manager switch --flake ~/.config/nix
```

## Update

If there is a change made to Minix, you can update your subscription by running
```sh
nix flake update
```
in `~/.config/nix`. This will update you to the newest version of Minix and any 
dependency of Minix. Rebuild your NixOS and/or home manager and you'll see the effect.

