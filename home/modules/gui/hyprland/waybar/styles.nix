{ config, ... }:
let
  theme =
    {
      font = config.stylix.fonts.sansSerif.name;
      widget_font = config.stylix.fonts.monospace.name;
      font_weight = "bold";
      black = "#${config.lib.stylix.colors.black}";
      blue = "#${config.lib.stylix.colors.blue}";
      cyan = "#${config.lib.stylix.colors.cyan}";
      green = "#${config.lib.stylix.colors.green}";
      magenta = "#${config.lib.stylix.colors.magenta}";
      red = "#${config.lib.stylix.colors.red}";
      white = "#${config.lib.stylix.colors.white}";
      yellow = "#${config.lib.stylix.colors.yellow}";
      brown = "#${config.lib.stylix.colors.brown}";
      background = "#${config.lib.stylix.colors.base00}";
      foreground = "#${config.lib.stylix.colors.base05}";
    };
in
{
  # Override Stylix
  stylix.targets.waybar.enable = false;
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: ${theme.font};
        font-size: 14px;
        font-weight: bold;
        color: ${theme.foreground};
        min-height: 0;
    }
    window#waybar {
        background: none;
    }
    tooltip {
        background-color: ${theme.background};
    }
    label.module {
        font-family: ${theme.widget_font};
        font-size: 1.5em;
        margin-left: 0.25em;
        margin-right: 0.25em;
    }
    #clock {
        font-family: ${theme.font};
        font-size: inherit;
    }
    #power-profiles-daemon.performance {
        color: ${theme.red};
    }
    #power-profiles-daemon.balanced {
        color: ${theme.blue};
    }
    #power-profiles-daemon.power-saver {
        color: ${theme.green};
    }
    #battery {
        font-size: 1em;
    }
    #battery.warning:not(.charging) {
        color: ${theme.yellow};
    }
    #battery.critical:not(.charging) {
        color: ${theme.red};
    }
    #workspaces button {
        border-bottom: 3px solid transparent;
    }
    #workspaces button.focused,
    #workspaces button.active {
        border-bottom: 3px solid ${theme.foreground};
    }
    #group-power {
        margin-bottom: 0;
    }
    #group-power .text-button {
        font-weight: normal;
    }
    #group-power .drawer .text-button {
        padding-top: 2px;
        padding-bottom: 2px;
    }
    #custom-power {
        color: ${theme.red};
    }
    #custom-reboot {
        color: ${theme.yellow};
    }
    #custom-lock {
        color: ${theme.blue};
    }
    #custom-quit {
        color: ${theme.brown};
    }
  '';
}

