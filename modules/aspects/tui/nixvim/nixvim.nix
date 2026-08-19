{ den, ... }:
{
  flake-file.inputs.nixvim = {
    url = "github:cfrenette/nixvim";
  };

  den.default.includes = [ den.batteries.inputs' ];

  den.aspects.nixvim = {
    homeManager = { inputs', ... }: {

      home.packages = [
        inputs'.nixvim.packages.default
      ];

      stylix.targets.nixvim.enable = false;

      home.sessionVariables = {
        EDITOR = "nvim";
      };
    };
  };
}
