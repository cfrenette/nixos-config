{ den, ... }:
{
  den.aspects.nixvim._.languages._.java = {
    includes = [
      den.aspects.nixvim._.conform
      den.aspects.nixvim._.lsp
    ];
    homeManager.programs.nixvim.plugins = {
      conform-nvim = {
        settings.formatters_by_ft.java = [ "google-java-format" ];
      };
      lsp.servers.jdtls = {
        enable = true;
        packageFallback = true;
      };
    };
  };
}
