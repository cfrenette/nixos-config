{ den, ... }:
{
  # Full interactive terminal environment.
  den.aspects.tui = {
    includes = [
      den.aspects.headless
      den.aspects.nh
      den.aspects.fonts
    ];
  };
}
