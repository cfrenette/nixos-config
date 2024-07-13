{ pkgs, config, lib, ... }:
{
  # Override stylix
  stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          font = "FiraCode Nerd Font Medium 12";

          fg0 = mkLiteral "#ddc7a1";
          bg0 = mkLiteral "#202020";
          bg1 = mkLiteral "#2a2827";
          accent-color = mkLiteral "#7daea3";
          urgent-color = mkLiteral "#ea6962";

          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg0";

          margin = mkLiteral "0em";
          padding = mkLiteral "0em";
          spacing = mkLiteral "0em";
        };

        window = {
          location = mkLiteral "center";
          width = mkLiteral "30%";
          border-radius = mkLiteral "0.167em";
          background-color = mkLiteral "@bg0";
        };

        inputbar = {
          padding = mkLiteral "0.5em";
          spacing = mkLiteral "0.5em";
          background-color = mkLiteral "@bg1";
        };

        "prompt, entry, element-icon, element-text" = {
          vertical-align = mkLiteral "0.5";
        };

        prompt = {
          text-color = lib.mkForce (mkLiteral "@accent-color");
        };

        textbox = {
          padding = mkLiteral "0.5em";
          background-color = mkLiteral "@bg1";
        };

        listview = {
          padding = mkLiteral "0.25em 0";
          lines = 8;
          columns = 1;
          fixed-height = false;
        };

        element = {
          padding = mkLiteral "0.5em";
          spacing = mkLiteral "0.5em";
        };

        "element normal normal" = {
          text-color = mkLiteral "@fg0";
        };

        "element normal urgent" = {
          text-color = mkLiteral "@urgent-color";
        };

        "element normal active" = {
          text-color = mkLiteral "@accent-color";
        };

        "element alternate active" = {
          text-color = mkLiteral "@accent-color";
        };

        "element selected" = {
          text-color = mkLiteral "@bg0";
        };

        "element selected normal, element selected active" = {
          background-color = mkLiteral "@accent-color";
        };

        "element selected urgent" = {
          background-color = mkLiteral "@urgent-color";
        };

        "element-icon" = {
          size = mkLiteral "1em";
        };

        "element-text" = {
          text-color = mkLiteral "inherit";
        };
      };
  };
}

