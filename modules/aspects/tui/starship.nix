{
  den.aspects.starship = {
    homeManager = {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        presets = [
          "nerd-font-symbols"
          "bracketed-segments"
        ];
        settings = {
          format = "$directory$nix_shell$git_branch$character";
          cmd_duration = {
            disabled = true;
          };
          git_branch = {
            format = "[$symbol$branch(:$remote_branch)]($style) ";
          };
          line_break = {
            disabled = true;
          };
          nix_shell = {
            format = "[$symbol($name)]($style) ";
            pure_msg = "";
            impure_msg = "";
          };
          package = {
            disabled = true;
          };
        };
      };
    };
  };
}
