{
  den.aspects.nixvim._.telescope = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.ripgrep
        ];
        programs.nixvim.plugins.web-devicons.enable = true;
        programs.nixvim.plugins.telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = {
              action = "find_files";
              options = {
                desc = "[F]ind [F]iles";
              };
            };
            "<leader>fg" = {
              action = "live_grep";
              options = {
                desc = "[F]ind [G]rep";
              };
            };
            "<leader>fh" = {
              action = "help_tags";
              options = {
                desc = "[F]ind [H]elp Tags";
              };
            };
            "<leader>fd" = {
              action = "diagnostics";
              options = {
                desc = "[F]ind [D]iagnostics";
              };
            };
          };

        };
      };
  };
}
