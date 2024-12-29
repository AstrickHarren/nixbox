{ config, lib, ... }:
{
  catppuccin.enable = true;
  catppuccin.flavor = lib.mkDefault "mocha";
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings.flavor = config.catppuccin.flavor;
    };
  };
}
