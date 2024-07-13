{
  programs.nixvim = {
    opts = {

      # Line Numbers
      number = true;
      relativenumber = true;

      # Tabs
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;

      # Search
      hlsearch = false;
      incsearch = true;

      # Display
      wrap = false;
      termguicolors = true;
      signcolumn = "yes";
      scrolloff = 5;
    };
  };
}

