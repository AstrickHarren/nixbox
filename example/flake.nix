{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixbox = {
      url = "github:AstrickHarren/nixbox/unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.nixbox.mkNixbox {
      inherit inputs;
      settings = {
        # Change here !!!
        userName = "astrick";
        hostName = "helium";
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

        nixbox = {
          # If you want to install nvidia driver, usually required if your
          # laptop doesn't have a second GPU
          nvidia.enable = true;

          # Install rootLESS! docker, unfortunately, rootFUL doocker is not
          # supported by NixBox. Docker data is put in `~/.cache`
          dockerRootless.enable = true;
        };

        system = "x86_64-linux";
        stateVersion = "24.11";
      };
    };
}
