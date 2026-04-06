{ den, ... }:
{
  den.aspects.nixvim._.languages._.nix = {
    includes = [
      den.aspects.nixvim._.conform
      den.aspects.nixvim._.lsp
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.nixfmt ];
        programs.nixvim.plugins = {
          conform-nvim = {
            settings.formatters_by_ft.nix = [ "nixfmt" ];
          };
          lsp.servers.nixd = {
            enable = true;
            settings.formatting.command = [ "nixfmt" ];
          };
        };
      };
  };
}
