{ den, ... }:
{
  den.aspects.tui = {
    includes = [
      den.aspects.nh
      den.aspects.nixvim
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          ripgrep
        ];
      };
  };
}
