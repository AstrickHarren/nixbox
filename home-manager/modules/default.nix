{
  lib,
  nixboxLib,
  config,
  ...
}@input:
{
  options = {
    minix.enable = lib.mkEnableOption "Enable minix integrations by default";
    minix.nixvim.enable = lib.mkEnableOption "Enable minix's Neovim Config";
    minix.hyprlock.enable = lib.mkEnableOption "Enable hyprlock";
    minix.lang.rust.enable = lib.mkEnableOption "Enable rust";
  };

  config.minix = {
    nixvim.enable = lib.mkDefault config.minix.enable;
    hyprlock.enable = lib.mkDefault config.minix.enable;
    lang.rust.enable = lib.mkDefault config.minix.enable;
  };

  imports = [
    ./cursor.nix
    ./fish.nix
    ./git.nix
    ./librewolf
    ./hyprland.nix
    (nixboxLib.mkModuleIf config.minix.hyprlock.enable ./hyprlock.nix)
    ./kitty.nix
    (nixboxLib.mkModuleIf config.minix.nixvim.enable ./nixvim.nix)
    ./utils.nix
    (nixboxLib.mkModuleIf config.minix.lang.rust.enable ./lang/rust.nix)
    ./ignis.nix
  ];
}
