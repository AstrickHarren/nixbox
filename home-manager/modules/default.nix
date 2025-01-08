{
  lib,
  config,
  pkgs,
  ...
}@input:
let
  mkModuleIf = (import ../../util/mkModule.nix input).mkModuleIf;

  enableOptions = {
    nixvim.enable = lib.mkEnableOption "nixvim";
    hyprlock.enable = lib.mkEnableOption "hyprlock";
    lang.rust.enable = lib.mkEnableOption "rust";
    ignis.enable = lib.mkEnableOption "ignis";
  };

  enableDefaults = lib.mapAttrsRecursiveCond (as: !(as ? "_type")) (
    k: _: lib.mkDefault config.nixbox.enable
  ) enableOptions;
in
{
  options.nixbox = {
    enable = lib.mkEnableOption "nixbox integrations by default";
  } // enableOptions;
  config.nixbox = enableDefaults;

  imports = [
    ./cursor.nix
    ./fish.nix
    ./git.nix
    ./librewolf
    ./hyprland.nix
    ./hyprlock.nix
    ./kitty.nix
    (mkModuleIf config.nixbox.nixvim.enable ./nixvim)
    (mkModuleIf config.nixbox.enable ./utils.nix)
    (mkModuleIf config.nixbox.lang.rust.enable ./lang/rust.nix)
    (mkModuleIf config.nixbox.ignis.enable ./ignis.nix)
  ];
}
