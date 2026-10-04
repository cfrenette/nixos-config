{ den, ... }:
{
  den.aspects.solstice = {
    includes = [
      den.aspects.sops._.userKey
      den.aspects.hardware._.solstice
      den.aspects.workstation
      den.aspects.tpm-unlock
      den.aspects.cosmic
      den.aspects.qmk
      den.aspects.stylix
      den.aspects.sound
      den.aspects.gaming
      den.aspects.binfmt._.aarch64
    ];
    provides.cory = {
      includes = [
        den.aspects.sops
        den.aspects.tui
        den.aspects.ssh
        den.aspects.backups
        den.aspects.git._.home
        den.aspects.opencode
        den.aspects.gui
      ];
    };
    nixos =
      { pkgs, ... }:
      {
        system.stateVersion = "26.05";

        # Lets OpenRGB reach the SMBus/i2c controllers the firmware reserves.
        boot = {
          kernelModules = [ "i2c-dev" ];
          kernelParams = [ "acpi_enforce_resources=lax" ];
        };
        services.hardware.openrgb = {
          enable = true;
          package = pkgs.openrgb-with-all-plugins;
          startupProfile = "all-off";
        };
      };
  };
}
