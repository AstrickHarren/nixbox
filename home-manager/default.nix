{
  settings,
  ...
}:
{
  home.username = settings.userName;
  home.homeDirectory = "/home/${settings.userName}";
  home.stateVersion = settings.stateVersion;

  home.shellAliases = {
    hms = "home-manager switch --flake $FLAKE";
    nixs = "sudo nixos-rebuild switch --flake $FLAKE";
  };

  imports = [
    ./modules
    ./themes
  ];

  programs.home-manager.enable = true;
}
