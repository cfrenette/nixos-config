{ inputs, ... }:
{
  den.aspects.nixvim =
    { host, ... }:
    {
      homeManager =
        { pkgs, ... }:
        let
          extensions = import ./_extensions/extensions.nix;
          nixvim = inputs.nixvim.packages.${host.system}.default.extend extensions;
        in
        {
          stylix.targets.nixvim.enable = false;
          home.packages = [
            nixvim
            pkgs.beautysh
            pkgs.nixfmt
          ];
          home.sessionVariables = {
            EDITOR = "nvim";
          };
        };
    };
}
