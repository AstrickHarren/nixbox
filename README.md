# Minix

A minimal starting setup for nixvim.

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

Add the following to your `home.nix` file and you can change it to your liking. 
This is where nix home manager come into play. To find all the options you can 
put here, refer to [nix home manager options](https://nix-community.github.io/home-manager/options.xhtml).

```nix
{ settings, ... }:
{
  programs = {
    git = {
      enable = true;
      # this is your laptop username, change it if you like
      userName = settings.userName; 
      userEmail = "YOUR_EMAIL";
    };
    fish.enable = true;
    kitty.enable = true;
    nixvim.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "$HOME/.config/nix";
  };

  wayland.windowManager.hyprland.enable = true;
}
```

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

