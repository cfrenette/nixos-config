{
  den.aspects.nixvim._.conform = {
    homeManager = {
      programs.nixvim.plugins.conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_format = "fallback";
            timeoutMs = 500;
          };
        };
      };
    };
  };
}
