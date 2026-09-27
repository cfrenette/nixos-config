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
    nixos = {
      system.stateVersion = "26.05";
    };
  };
}
