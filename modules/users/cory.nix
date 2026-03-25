{ den, ... }:
{
  den.aspects.cory = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      den.aspects.sops
      den.aspects.git
      den.aspects.ssh
      den.aspects.backups
      den.aspects.mumble
      den.aspects.fonts
      den.aspects.tui
      den.aspects.gui
    ];
  };
}
