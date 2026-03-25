{
  den.aspects.alacritty = {
    homeManager =
      { lib, ... }:
      {
        programs.alacritty = {
          enable = true;
          settings = {
            # Override stylix
            font = lib.mkForce {
              size = 10;
              normal = {
                family = "IntoneMono Nerd Font";
                style = "Regular";
              };
              bold = {
                family = "IntoneMono Nerd Font";
                style = "Bold";
              };
              italic = {
                family = "IntoneMono Nerd Font";
                style = "Italic";
              };
              bold_italic = {
                family = "IntoneMono Nerd Font";
                style = "Bold Italic";
              };
            };
          };
        };
      };
  };
}
