{ den, ... }:
{
  den.aspects.sound = den.lib.perHost {
    nixos =
      { lib, ... }:
      {
        services = {
          pulseaudio.enable = lib.mkDefault false;
          pipewire = {
            enable = lib.mkDefault true;
            alsa.enable = lib.mkDefault true;
            alsa.support32Bit = lib.mkDefault true;
            pulse.enable = lib.mkDefault true;
            wireplumber.enable = lib.mkDefault true;
          };
        };
        security.rtkit.enable = lib.mkDefault true;
      };
  };
}
