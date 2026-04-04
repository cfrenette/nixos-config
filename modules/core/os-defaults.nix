{ den, lib, ... }:
{
  den.aspects.os-defaults = {
    _.osConfig = den.lib.perHost {
      nixos = {
        nix.settings.experimental-features = lib.mkDefault [
          "nix-command"
          "flakes"
        ];

        networking.useDHCP = lib.mkDefault true;
        networking.networkmanager.enable = lib.mkDefault true;

        time.timeZone = lib.mkDefault "America/New_York";
        i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

        system.stateVersion = lib.mkDefault "24.05";
      };
    };
  };
}
