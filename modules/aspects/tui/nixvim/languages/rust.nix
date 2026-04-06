{ den, ... }:
{
  den.aspects.nixvim._.languages._.rust = {
    includes = [
      den.aspects.nixvim._.conform
      den.aspects.nixvim._.lsp
    ];
    homeManager.programs.nixvim.plugins = {
      conform-nvim = {
        settings.formatters_by_ft.rust = [ "rustfmt" ];
      };
      lsp.servers.rust_analyzer = {
        enable = true;
        # Use the more up-to-date versions in a devshell
        installRustc = false;
        installCargo = false;
      };
    };
  };
}
