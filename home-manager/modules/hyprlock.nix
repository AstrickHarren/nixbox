{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        no_fade_in = true;
        no_fade_out = true;
        grace = 0;
        disable_loading_bar = true;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      # USER-BOX
      shape = [
        {
          size = "300, 60";
          color = "rgba(255, 255, 255, .1)";
          rounding = -1;
          border_size = 0;
          border_color = "rgba(255, 255, 255, 0)";
          rotate = 0;
          xray = false;

          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      # User Label
      label = [
        {
          text = "   $USER";
          color = "rgba(216, 222, 233, 0.80)";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          font_size = 18;
          font_family = "SF Pro Display Bold";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }

        # Time
        {
          text = "$TIME";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 130;
          font_family = "SF Pro Display Bold";
          position = "0, 240";
          halign = "center";
          valign = "center";
        }

      ];

      input-field = [
        {
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(255, 255, 255, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          roundings = -1;
          check_color = "rgb(204, 136, 34)";
          hide_input = false;
          position = "0, -210";
          shadow_passes = 2;
          halign = "center";
          valign = "center";
          placeholder_text = "";
        }
      ];
    };
  };
}
