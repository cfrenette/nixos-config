{ den, ... }:
{
  den.aspects.nixvim._.languages._.bash = {
    includes = [
      den.aspects.nixvim._.conform
      den.aspects.nixvim._.lsp
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.beautysh ];
        programs.nixvim.plugins = {
          conform-nvim = {
            settings.formatters_by_ft.bash = [ "beautysh" ];
          };
          lsp.servers.bashls.enable = true;
        };
      };
  };
}
