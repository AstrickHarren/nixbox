{ lib, config, ... }:
{
  options = {
    nixbox.hyprpaper = {
      wallpaperPath = lib.mkOption {
        type = lib.types.str;
        description = "path to wallpaper";
      };
    };
  };
  config = {
    services.hyprpaper.enable = true;
    services.hyprpaper.settings = {
      ipc = "on";
      splash = false;

      preload = lib.mkIf (config.nixbox.hyprpaper.wallpaperPath != null) [
        config.nixbox.hyprpaper.wallpaperPath
      ];
      wallpaper = lib.mkIf (config.nixbox.hyprpaper.wallpaperPath != null) [
        ", ${config.nixbox.hyprpaper.wallpaperPath}"
      ];
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "hyprpaper"
      ];
    };
  };
}
