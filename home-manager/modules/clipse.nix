{ pkgs, ... }:
{
  home.packages = with pkgs; [ clipse ];
  wayland.windowManager.hyprland.settings = {
    exec-once = [ "clipse -listen" ];
    windowrulev2 = [
      "float,class:(clipse)"
      "size 1200 1200,class:(clipse)"
    ];
    bind = [ "SUPER, V, exec,  kitty --class clipse -e 'clipse'" ];
  };
}
