{ lib, ... }:
# let 
# Managed by stylix
# theme = {
#     black = "0x3c3836";
#     blue = "0x7daea3";
#     cyan = "0x89b482";
#     green = "0xa9b665";
#     magenta = "0xd3869b";
#     red = "0xea6962";
#     white = "0xd4be98";
#     yellow = "0xd8a657";
#     background = "0x282828";
#     foreground = "0xd4be98";
# };
# in 
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
}

