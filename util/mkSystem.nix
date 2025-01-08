{
  inputs,
  settings,
  homeModules ? [ ],
  nixosModules ? [ ],
}:
let
  nixboxLib = import ./mkModule.nix;
in
{
  nixosConfigurations.${settings.hostName} = inputs.nixpkgs.lib.nixosSystem {
    system = settings.system;
    modules = nixosModules;
    specialArgs = {
      inherit inputs settings;
    };
  };

  homeConfigurations.${settings.userName} =
    let
      pkgs = inputs.nixpkgs.legacyPackages.${settings.system};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = homeModules;
      extraSpecialArgs = {
        inherit inputs settings;
        nixboxLib = nixboxLib { lib = pkgs.lib; };
      };
    };
}
