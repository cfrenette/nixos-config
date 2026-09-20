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

      home.sessionVariables = {
        EDITOR = "nvim";
      };
    };
  };

  # Disable stylix on hosts that use it so the Nixvim theme is used.
  den.aspects.stylix.nixos.home-manager.sharedModules = [
    { stylix.targets.nixvim.enable = false; }
  ];
}
