{ pkgs, ... }:
{
  home.packages = with pkgs; [ hyprshot ];
  wayland.windowManager.hyprland.settings = {
    bind = [ "$mod SHIFT, S, exec,  hyprshot -m region -o $HOME/Pictures/screenshots" ];
  };
}
