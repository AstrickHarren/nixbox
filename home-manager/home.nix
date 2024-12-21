{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.username = "dk";
  home.homeDirectory = "/home/dk";
  home.stateVersion = "24.05";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.shellAliases = {
    hms = "home-manager switch";
  };
  home.sessionVariables = {
    FLAKE = "$HOME/.config/nixos";
  };

  imports = [
    ./modules
    ./themes
  ];

  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
    font.name = "Fira Code";
  };
}
