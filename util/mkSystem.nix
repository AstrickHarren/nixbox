{
  inputs,
  settings,
  homeModules ? [ ],
  nixosModules ? [ ],
}:
{
  nixosConfigurations.${settings.hostName} = inputs.nixpkgs.lib.nixosSystem {
    system = settings.system;
    modules = nixosModules;
    specialArgs = {
      inherit inputs settings;
    };
  };

  homeConfigurations.${settings.userName} = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${settings.system};
    modules = homeModules;
    extraSpecialArgs = {
      inherit inputs settings;
    };
  };
}
