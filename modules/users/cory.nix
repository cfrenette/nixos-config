{ den, ... }:
{
  den.aspects.cory = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      den.aspects.fonts
      den.aspects.tui
    ];
  };
}
