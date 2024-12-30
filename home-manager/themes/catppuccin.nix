{ config, lib, ... }:
{
  catppuccin.enable = true;
  catppuccin.flavor = lib.mkDefault "mocha";
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = config.catppuccin.flavor;
      autoLoad = true;
    };
  };
}
