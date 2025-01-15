{
  lib,
  config,
  pkgs,
  ...
}@input:
let
  mkModuleIf = (import ../../util/mkModule.nix input).mkModuleIf;

  subModules = {
    cursor = ./cursor.nix;
    fish = ./fish.nix;
    git = ./git.nix;
    librewolf = ./librewolf;
    hyprland = ./hyprland.nix;
    hyprlock = ./hyprlock.nix;
    hyprshot = ./hyprshot.nix;
    kitty = ./kitty.nix;
    nixvim = ./nixvim;
    lang.rust = ./lang/rust.nix;
    ignis = ./ignis.nix;
    clipse = ./clipse.nix;
    betterfox = ./betterfox.nix;
  };

  enableOptions =
    (lib.mapAttrsRecursive (k: v: {
      enable = lib.mkEnableOption (lib.elemAt k (lib.length k - 1));
    }) subModules)
    // {
      enable = lib.mkEnableOption "nixbox integrations by default";
    };
  enableDefaults = lib.mapAttrsRecursive (k: _: {
    enable = lib.mkDefault config.nixbox.enable;
  }) subModules;

  mkImport =
    p: ms:
    lib.flatten (
      lib.mapAttrsToList (
        k: v: if lib.isAttrs v then mkImport p.${k} v else [ (mkModuleIf p.${k}.enable v) ]
      ) ms
    );
in
{
  options.nixbox = enableOptions;
  config.nixbox = enableDefaults;
  imports = mkImport config.nixbox subModules ++ [
    (mkModuleIf config.nixbox.enable ./utils.nix)
  ];
}
