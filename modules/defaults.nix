{ lib, ... }:
{
  den.default = {
    nixos = {
      system.stateVersion = lib.mkDefault "24.05";

      nix.settings.experimental-features = lib.mkDefault [
        "nix-command"
        "flakes"
      ];

      networking.useDHCP = lib.mkDefault true;
      networking.networkmanager.enable = lib.mkDefault true;

      time.timeZone = lib.mkDefault "America/New_York";
      i18n = lib.mkDefault {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
          LC_ADDRESS = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "en_US.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };
      };
    };
  };
}
