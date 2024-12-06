{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          componentSeparators = {
            left = "";
            right = "";
          };
          iconsEnabled = false;
          sectionSeparators = {
            left = "";
            right = "";
          };
        };
      };
    };
    # Mode is already shown in Lualine
    opts = {
      showmode = false;
    };
  };
}

