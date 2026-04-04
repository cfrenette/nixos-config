{ den, ... }:
{
  den.aspects.cory = {
    includes = [
      den.provides.primary-user
      (den.provides.user-shell "bash")
      den.aspects.fonts
      den.aspects.tui
    ];
  };
}
