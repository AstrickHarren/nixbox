{
  lib,
  config,
  pkgs,
  ...
}@input:
let
  mkModuleIf = (import ../../util/mkModule.nix input).mkModuleIf;

  enableOptions = {
    nixvim.enable = lib.mkEnableOption "minix";
    hyprlock.enable = lib.mkEnableOption "hyprlock";
    lang.rust.enable = lib.mkEnableOption "rust";
  };

  enableDefaults = lib.mapAttrsRecursiveCond (as: !(as ? "_type")) (
    k: _: lib.mkDefault config.minix.enable
  ) enableOptions;
in
{
  options.minix = {
    enable = lib.mkEnableOption "Enable minix integrations by default";
  } // enableOptions;
  config.minix = enableDefaults;

  imports = [
    ./cursor.nix
    ./fish.nix
    ./git.nix
    ./librewolf
    ./hyprland.nix
    ./hyprlock.nix
    ./kitty.nix
    ./nixvim
    (mkModuleIf config.minix.enable ./utils.nix)
    (mkModuleIf config.minix.lang.rust.enable ./lang/rust.nix)
    ./ignis.nix
  ];
}
