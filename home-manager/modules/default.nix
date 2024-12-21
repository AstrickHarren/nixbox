{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./git.nix
    ./hyprland.nix
    ./kitty.nix
    ./nixvim
  ];

  config = {
    home.packages = with pkgs; [ 
      curl wget httpie wl-clipboard libqalculate
    ];
    programs.bat.enable = true;
  };
}
