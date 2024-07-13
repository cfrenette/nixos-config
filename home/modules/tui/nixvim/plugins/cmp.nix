{
  programs.nixvim.plugins.cmp = {
    enable = true;
    settings = {
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.close()";
        "<C-y>" = "cmp.mapping.confirm({ select = true })";
        "<C-u>" = "cmp.mapping.scroll_docs(-4)";
        "<C-d>" = "cmp.mapping.scroll_docs(4)";
        "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
        "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
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

  # Snippet engine
  programs.nixvim.plugins.luasnip = {
    enable = true;
  };
}

