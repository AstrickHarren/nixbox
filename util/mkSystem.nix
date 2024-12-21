{
  inputs,
  settings,
  modules,
}:
let
  module =
    {
      pkgs,
      ...
    }:

    {
      imports = [ settings.hardware ];
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      boot = settings.boot;

      fonts.packages = with pkgs; [
        fira-code-nerdfont
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        fantasque-sans-mono
      ];

      networking.hostName = settings.hostName;
      networking.networkmanager.enable = true;

      time.timeZone = "US/Central";

      hardware.graphics.enable = true;
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;

      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };

      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
        daemon.settings = {
          data-root = "/home/${settings.userName}/.cache/docker";
        };
      };

      users.users.${settings.userName} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
        ];
      };

      environment.systemPackages = with pkgs; [
        home-manager
      ];
      system.stateVersion = settings.stateVersion;
    };
in
{
  nixosConfigurations.${settings.hostName} = inputs.nixpkgs.lib.nixosSystem {
    system = settings.system;
    modules = [ module ];
  };

  homeConfigurations.${settings.userName} = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${settings.system};
    extraSpecialArgs = {
      inherit inputs settings;
    };
    modules = [
      ../home-manager
      settings.home
    ] ++ modules;
  };
}
