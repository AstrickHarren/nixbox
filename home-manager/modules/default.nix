{
  pkgs,
  lib,
  config,
  ...
}@input:
let
  mkDefaultModule =
    mod:
    let
      module =
        let
          module = import mod;
        in
        if lib.isFunction module then module input else module;
      config = module.config or module;
      isNotMergable = value: (lib.isBool value || lib.isInt value || lib.isFloat value);
    in
    {
      imports = lib.map mkDefaultModule (module.imports or [ ]);
      options = module.options or { };
      config = lib.mapAttrsRecursive (
        _: value: if isNotMergable value then lib.mkDefault value else value
      ) config;
    };

  mkCondModule =
    enableAll: mod:
    let
      cond = if lib.isAttrs mod then (lib.or mod.enable enableAll) else enableAll;
      module = mkDefaultModule (if lib.isAttrs mod then mod.module else mod);
    in
    {
      imports = module.imports;
      options = module.options;
      config = lib.mkIf cond module.config;
    };
in
{
  options = {
    minix.enable = lib.mkEnableOption "Enabel minix integrations by default";
    minix.nixvim.enable = lib.mkEnableOption "Enabel minix's Neovim Config";
  };

  imports = lib.map (mkCondModule config.minix.enable) [
    ./cursor.nix
    ./fish.nix
    ./git.nix
    ./librewolf
    ./hyprland.nix
    ./hyprlock.nix
    ./kitty.nix
    {
      enable = config.minix.nixvim.enable;
      module = ./nixvim;
    }
    ./utils.nix
  ];
}
