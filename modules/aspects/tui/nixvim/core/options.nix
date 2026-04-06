{
  den.aspects.nixvim._.options = {
    homeManager.programs.nixvim = {
      opts = {

        # Line Numbers
        number = true;
        relativenumber = true;

        # Tabs
        shiftwidth = 4;
        softtabstop = -1;
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
        cursorline = true;
        cursorlineopt = "number";
      };

      autoCmd = [
        # Exception for nix indentation
        {
          event = "FileType";
          pattern = "nix";
          command = "setlocal shiftwidth=2";
        }
      ];
    };
  };
}
