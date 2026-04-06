{
  den.aspects.nixvim._.cmp = {
    homeManager.programs.nixvim.plugins.cmp = {
      enable = true;
      settings = {
        mapping = {
          "<c-Space>" = "cmp.mapping.complete()";
          "<c-e>" = "cmp.mapping.close()";
          "<c-CR>" = "cmp.mapping.confirm({ select = true })";
          "<c-u>" = "cmp.mapping.scroll_docs(-4)";
          "<c-d>" = "cmp.mapping.scroll_docs(4)";
          "<c-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
          "<c-n>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
        };
        sources = [
          {
            name = "nvim_lsp";
          }
          {
            name = "luasnip";
          }
          {
            name = "path";
          }
        ];
        snippet.expand = ''
          function(args)
              require('luasnip').lsp_expand(args.body)
          end
        '';
      };
    };
  };
}
