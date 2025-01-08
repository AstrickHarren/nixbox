{
  lib,
  config,
  pkgs,
  ...
}@input:
let
  mkModuleIf = (import ../../util/mkModule.nix input).mkModuleIf;

  enableOptions =
    lib.mapAttrsRecursive
      (k: v: {
        enable = lib.mkEnableOption (if v == null then (lib.elemAt k (lib.length k - 1)) else v);
      })
      {
        nixvim = null;
        hyprlock = null;
        lang.rust = null;
        ignis = null;
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
    (mkModuleIf config.nixbox.cursor.enable ./cursor.nix)
    (mkModuleIf config.nixbox.fish.enable ./fish.nix)
    (mkModuleIf config.nixbox.git.enable ./git.nix)
    (mkModuleIf config.nixbox.librewolf.enable ./librewolf)
    (mkModuleIf config.nixbox.hyprland.enable ./hyprland.nix)
    (mkModuleIf config.nixbox.hyprlock.enable ./hyprlock.nix)
    (mkModuleIf config.nixbox.kitty.enable ./kitty.nix)
    (mkModuleIf config.nixbox.nixvim.enable ./nixvim)
    (mkModuleIf config.nixbox.enable ./utils.nix)
    (mkModuleIf config.nixbox.lang.rust.enable ./lang/rust.nix)
    (mkModuleIf config.nixbox.ignis.enable ./ignis.nix)
  ];
}
