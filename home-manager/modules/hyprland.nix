{
  pkgs,
  ...
}:

let
  bind_switch_workspace = builtins.concatLists (
    builtins.genList (
      i:
      let
        x = builtins.toString (i + 1);
      in
      [
        "$mod, ${x}, workspace, ${x}"
        "$mod SHIFT, ${x}, movetoworkspace, ${x}"
      ]
    ) 9
  );
in
{

  home.packages = with pkgs; [ playerctl ];
  services.playerctld.enable = true;

  wayland.windowManager.hyprland = {
    package = pkgs.hyprland;
    # xwayland.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    decoration = {
      rounding = 10;
    };

    gestures.workspace_swipe = true;

    binds = {
      allow_workspace_cycles = true;
    };
    bind = [
      # IMPORTANT: use `wev` to determine the keycode names
      "$mod, Slash, exec, firefox"
      "$mod, Return, exec, kitty"
      "$mod, M, exec, spotify --enable-features=UseOzonePlatform --ozone-platform=wayland"
      "$mod, Q, killactive"

      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      "$mod CTRL, H, workspace, -1"
      "$mod CTRL, L, workspace, +1"
      "$mod SHIFT CTRL, H, movetoworkspace, -1"
      "$mod SHIFT CTRL, L, movetoworkspace, +1"
      "$mod, Tab, workspace, previous"
    ] ++ bind_switch_workspace;
    bindl = [
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"
    ];
    binde = [
      "$mod, Equal, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      "$mod, Minus, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    misc = {
      focus_on_activate = true;
    };
  };
}
