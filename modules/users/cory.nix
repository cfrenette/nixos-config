{ den, ... }:
{
  den.aspects.cory = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      den.aspects.ssh
      den.aspects.backups
      den.aspects.mumble
      den.aspects.git._.home
      den.aspects.fonts
      den.aspects.tui
      den.aspects.gui
    ];
  };
}
