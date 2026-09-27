{ den, ... }:
{
  den.aspects.laptop = {
    includes = [ den.aspects.workstation ];
    nixos =
      { pkgs, ... }:
      {
        services.libinput.touchpad = {
          tapping = false;
          clickMethod = "clickfinger";
          naturalScrolling = true;
        };

        services.logind.settings.Login.HandlePowerKey = "suspend";

        environment.systemPackages = [ pkgs.brightnessctl ];
      };
  };
}
