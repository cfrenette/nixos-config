{ den, ... }:
{
  den.aspects.headless = {
    includes = [
      den.aspects.nixvim
      den.aspects.starship
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
