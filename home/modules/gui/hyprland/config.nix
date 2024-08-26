{ pkgs, config, osConfig, ... }:
{
  wayland.windowManager.hyprland = {
    settings = {

      exec-once = [
        "${pkgs.wbg}/bin/wbg ${config.stylix.image} &"
        "${pkgs.mako}/bin/mako &"
      ];

      general = {
        "$mod" = "SUPER";
        layout = "dwindle";
        gaps_in = 1;
        gaps_out = 0;
        border_size = 2;
      };

      misc = {
        disable_hyprland_logo = true;
        vrr = 1;
      };

      input = let libInput = osConfig.services.libinput; in {
        accel_profile = libInput.mouse.accelProfile;
        touchpad = {
          natural_scroll = libInput.touchpad.naturalScrolling;
          tap-to-click = libInput.touchpad.tapping;
          clickfinger_behavior = libInput.touchpad.clickMethod == "clickfinger";
        };
      };

      # Normal bindings
      bind = [

        "$mod, f1, exec, show-keybinds"

        "$mod, t, exec, alacritty"
        "$mod, q, killactive"
        "$mod, space, exec, rofi -show drun -show-icons"
        "$mod, return, fullscreen"
        "$mod, delete, exec, hyprlock"

        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        # TODO: ", XF86_AudioPrev, exec, [previous]"
        # TODO: ", XF86_AudioPlay, exec, [play/pause]"
        # TODO: ", XF86_AudioNext, exec, [next]"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        "$mod, p, exec, hyprctl reload"
        # TODO: ", XF86RFKill, exec, [toggle wifi/bluetooth] 
        # TODO: ", XF86AudioMedia, exec, [settings?]"
      ]
      ++ (
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10
        )
      );

      # Bindings available during screen lock
      bindl = [
        # Internal display
        # off on lid close
        # ",switch:on:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, disable'"
        # on on lid open
        # ",switch:off:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, disable'"
      ];
    };
    extraConfig = "
            # monitor=name,resolution,position,scale
            # (disabled, managed by kanshi)

            # External Monitors (run hyprctl monitors)
            # monitor=DP-1,preferred,0x0,2
            # monitor=DP-2,preferred,1920x0,2
        ";
  };

}

