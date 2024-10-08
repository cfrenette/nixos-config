{ ... }:
{
  imports = [
    #./gnome
    #./hyprland
    ./cosmic
    ./qmk.nix
    ./stylix.nix
  ];

  # Configure keymap 
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    libinput = {
      enable = true;
      # disable mouse acceleration
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        tapping = false;
        clickMethod = "clickfinger";
        naturalScrolling = true;
      };
    };
  };
}

