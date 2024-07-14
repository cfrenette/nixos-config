{ ... }:
{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
            scale = 1.6;
            status = "enable";
          }
        ];
      };

      docked_home = {
        outputs = [
          {
            criteria = "ASUSTek COMPUTER INC ASUS VG289 0x0002AD32";
            position = "0,0";
            mode = "3840x2160";
            # adaptiveSync = true;
            scale = 2.0;
            status = "enable";
          }
          {
            criteria = "ASUSTek COMPUTER INC ASUS VG289 0x0002AD37";
            position = "1920,0";
            mode = "3840x2160";
            # adaptiveSync = true;
            scale = 2.0;
            status = "enable";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };
    };
  };
}

