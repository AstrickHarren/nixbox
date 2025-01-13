{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ignis = {
      url = "github:AstrickHarren/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ignis-config = {
      url = "github:astrickharren/ignis-config";
      flake = false;
    };
  };

  outputs =
    nixboxInputs:
    let
      mkSystem = import ./util/mkSystem.nix;
    in
    {
      mkNixbox =
        {
          inputs,
          settings,
        }:
        mkSystem {
          inherit settings;
          inputs = nixboxInputs // inputs;
          homeModules = [
            ./home-manager
            settings.home
            nixboxInputs.catppuccin.homeManagerModules.catppuccin
            nixboxInputs.nixvim.homeManagerModules.nixvim
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                nixboxInputs.nur.overlays.default
              ];
            }
          ];
          nixosModules = [
            ./os/default.nix
            settings.os or { }
            {
              nixbox = settings.nixbox;
            }
          ];
        };
    };
}
