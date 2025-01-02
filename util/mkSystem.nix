{
  inputs,
  settings,
  modules ? [ ],
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
    inherit modules;
    pkgs = inputs.nixpkgs.legacyPackages.${settings.system};
    extraSpecialArgs = {
      inherit inputs settings;
    };
  };
}
