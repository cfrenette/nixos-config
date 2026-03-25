{
  den.aspects.laptop = {
    nixos = {
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
    };
  };
}
