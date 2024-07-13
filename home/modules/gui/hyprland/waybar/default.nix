{
  imports = [
    ./styles.nix
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      position = "top";
      height = 20;
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      fixed-center = true;
      modules-left = [
        "hyprland/workspaces"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "tray"
        "network"
        "wireplumber"
        "power-profiles-daemon"
        "battery"
        "group/group-power"
        # TODO: notifications
      ];
      "hyprland/workspaces" = {
        active-only = true;
      };
      clock = {
        calendar = {
          format = { today = "{}"; };
        };
        format = "{:%I:%M %p}";
      };
      tray = {
        icon-size = 15;
        spacing = "0.5em";
      };
      network = {
        format-disconnected = "󰲛";
        format-linked = "󰍸";
        format-wifi = "{icon}";
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
        tooltip-format-wifi = "{essid} ({frequency}GHz)";
        format-ethernet = "󰱓";
        tooltip-format-ethernet = "{ifname} {ipaddr}";
      };
      wireplumber = {
        format = "{icon}";
        format-muted = "";
        format-icons = [ "" "" "" ];
        tooltip = true;
        tooltip-format = "{volume}%";
        max-volume = 100.0;
        on-click-middle = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      };
      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "󰓅";
          performance = "󰓅";
          balanced = "󰜥";
          power-saver = "󰌪";
        };
      };
      battery = {
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        format = "{icon}";
        format-charging = "{icon}󱐋";
        format-full = "󱟢";
        format-warning = "{icon}󱈸";
        format-critical = "{icon}󱈸";
        states = {
          warning = 15;
          critical = 10;
        };
        format-time = "{H}h{M}m";
        tooltip = true;
        tooltip-format = "{capacity}%\n{timeTo}";
      };
      "group/group-power" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "not-power";
          transition-left-to-right = false;
        };
        modules = [
          "custom/power"
          "custom/quit"
          "custom/lock"
          "custom/reboot"
        ];
      };
      "custom/quit" = {
        format = "󰍃";
        tooltip = false;
        on-click = "hyprctl dispatch exit";
      };
      "custom/lock" = {
        format = "󰤄";
        tooltip = false;
        on-click = "loginctl lock-session && systemctl suspend";
      };
      "custom/reboot" = {
        format = "󰜉";
        tooltip = false;
        on-click = "reboot";
      };
      "custom/power" = {
        format = "";
        tooltip = false;
        on-click = "shutdown now";
      };
    };
  };
}

