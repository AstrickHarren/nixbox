{
  inputs,
  settings,
  modules,
}:
let
  module =
    {
      pkgs,
      config,
      ...
    }:

    let
      mkIf = flag: make: if flag then make else { };

      nvidiaDrm =
        (
          {
            nvidiaDriver ? {
              enable = false;
            },
            ...
          }:
          let
            driver = {
              version = "stable";
            } // nvidiaDriver;
          in
          mkIf driver.enable {
            nixpkgs.config.nvidia.acceptLicense = true;
            hardware.nvidia = {
              open = false;
              modesetting.enable = true;
              nvidiaSettings = true;
              package = config.boot.kernelPackages.nvidiaPackages.${driver.version};
            };
            services.xserver.videoDrivers = [ "nvidia" ];
          }
        )
          settings;

      docker =
        (
          {
            dockerRootless ? {
              enable = false;
            },
            ...
          }:
          mkIf dockerRootless.enable {
            virtualisation.docker.rootless = {
              enable = true;
              setSocketVariable = true;
              daemon.settings = {
                data-root = "/home/${settings.userName}/.cache/docker";
              };
            };
          }
        )
          settings;
    in
    nvidiaDrm
    // docker
    // {
      imports = [ settings.hardware ];
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      boot = settings.boot;

      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        nerd-fonts.fira-code
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.sauce-code-pro
        nerd-fonts.jetbrains-mono
        inputs.apple-fonts.packages.${settings.system}.sf-pro
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

      services.greetd = {
        enable = true;
        vt = 3;
        settings = {
          initial_session = {
            user = settings.userName;
            command = "Hyprland";
          };
          default_session = {
            user = settings.userName;
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a * %h | %F' --cmd Hyprland";
          };
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

      # Enable gtk4 apps
      programs.dconf.enable = true;

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
    inherit modules;
    pkgs = inputs.nixpkgs.legacyPackages.${settings.system};
    extraSpecialArgs = {
      inherit inputs settings;
    };
  };
}
