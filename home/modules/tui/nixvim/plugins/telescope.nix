{
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      # Not allowed yet in 24.05
      # "<leader>ff" = {
      #   action = "find_files";
      #   options = {
      #       desc = "[F]ind [F]iles"
      #   };
      # }
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>fh" = "help_tags";
      "<leader>fd" = "diagnostics";
    };
    # extensions = {
    #  ui-select.enable = true;
    # };
  };

  # Suppress warning about deprecated behavior
  programs.nixvim.plugins.web-devicons = {
    enable = false;
  };
}

