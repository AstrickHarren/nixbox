{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    catppuccin.url = "github:catppuccin/nix";
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
  };

  outputs =
    minixInputs:
    let
      mkSystem = import ./util/mkSystem.nix;
    in
    {
      mkMinix =
        {
          inputs,
          settings,
          modules ? [ ],
        }:
        mkSystem {
          inherit settings;
          inputs = minixInputs // inputs;
          modules = modules ++ [
            ./home-manager
            settings.home
            minixInputs.catppuccin.homeManagerModules.catppuccin
            minixInputs.nixvim.homeManagerModules.nixvim
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                minixInputs.nur.overlays.default
              ];
            }
          ];
          nixosModules = [
            ./os/default.nix
            {
              minix = settings.minix;
            }
          ];
        };
    };
}
