{ config, ... }:
let
  theme =
    let
      mkRgb = color:
        let
          c = config.lib.stylix.colors;
        in
        "rgb(${c.${color}})";
    in
    {
      font = config.stylix.fonts.sansSerif.name;
      background = mkRgb "base00";
      foreground = mkRgb "base07";
      red = mkRgb "base08";
      yellow = mkRgb "base0A";
      blue = mkRgb "base0D";
      brown = mkRgb "base0F";
    };
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 6;
        }
      ];

      label = [
        {
          text = "cmd[update:10000] echo $(date +\"%-I:%M %p\")";
          color = "${theme.foreground}";
          font_size = 48;
          font_family = "${theme.font}";
          position = "0, -300";
          halign = "center";
          valign = "top";
        }
        {
          text = "<b>$USER</b>";
          color = "${theme.foreground}";
          font_size = 28;
          font_family = "${theme.font}";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "300, 50";
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          outer_color = "${theme.blue}";
          inner_color = "${theme.background}";
          font_color = "${theme.foreground}";
          check_color = "${theme.yellow}";
          fail_color = "${theme.red}";
          fail_text = "<i>$FAIL</i>";
          capslock_color = "${theme.brown}";
          position = "0, -50";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}

