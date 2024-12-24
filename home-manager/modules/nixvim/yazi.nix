{ lib, config, ... }:
let
  cfg = config.programs.nixvim.plugins.yazi;
in
{
  options = {
    programs.nixvim.plugins.yazi.keymap.open = lib.mkOption { default = "<C-n>"; };
  };
  config.programs.nixvim = {
    keymaps = [
      {
        action.__raw = ''require("yazi").yazi'';
        key = cfg.keymap.open;
      }
    ];
  };
}
