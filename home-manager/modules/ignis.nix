{ inputs, settings, ... }:
{
  home.packages = [ inputs.ignis.packages.${settings.system}.ignis ];
  xdg.configFile."ignis".source = "${inputs.ignis-config}";
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "ignis init"
    ];
  };
}
