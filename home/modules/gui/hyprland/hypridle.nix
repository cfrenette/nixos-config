{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # Don't start another hyprlock if one is already running
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          # Set brightness low and remember current setting
          on-timeout = "brightnessctl -s set 10";
          # Restore the remembered setting
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          # Turn off the display
          on-timeout = "hyprctl dispatch dpms off";
          # Turn on the display
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          # Suspend
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}

