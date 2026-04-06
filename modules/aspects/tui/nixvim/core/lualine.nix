{
  den.aspects.nixvim._.lualine = {
    homeManager.programs.nixvim = {
      # Mode is already shown in lualine
      opts.showmode = false;
      plugins.lualine = {
        enable = true;
        settings = {
          options = {
            component_separators = {
              left = "";
              right = "";
            };
            icons_enabled = false;
            section_separators = {
              left = "";
              right = "";
            };
          };
        };
      };
    };
  };
}
