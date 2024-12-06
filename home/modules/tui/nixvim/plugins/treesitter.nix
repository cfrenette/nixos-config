{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        indent = {
          enable = true;
        };
      };
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };
  };
}

