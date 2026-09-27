{
  den.aspects.workstation = {
    nixos = {
      nixpkgs.config.allowUnfree = true;

      services = {
        xserver = {
          enable = true;
          xkb.layout = "us";
        };
        libinput = {
          enable = true;
          mouse.accelProfile = "flat";
        };
        avahi.enable = true;
        printing.enable = true;
        fwupd.enable = true;
      };

      hardware.bluetooth.enable = true;
    };
  };
}
