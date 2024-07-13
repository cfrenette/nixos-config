{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      indent = true;
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };
  };
}

