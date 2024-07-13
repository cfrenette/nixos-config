{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      iconsEnabled = false;
      componentSeparators = {
        left = "";
        right = "";
      };
      sectionSeparators = {
        left = "";
        right = "";
      };
      # theme = "gruvbox-material";
    };
    # Mode is already shown in Lualine
    opts = {
      showmode = false;
    };
  };
}

