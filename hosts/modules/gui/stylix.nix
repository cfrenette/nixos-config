{ inputs, pkgs, config, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;

    polarity = "dark";

    image = ../../../home/assets/wallpapers/fw-laptop-wireframe.png;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    override = {
      base00 = "1d2021";
    };

    opacity = {
      desktop = 0.0;
      popups = 0.6;
    };

    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
    };

    fonts = {
      sansSerif = {
        package = pkgs.fira;
        name = "Fira Sans";
      };
      serif = config.stylix.fonts.sansSerif;
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "FiraMono" ]; };
        name = "FiraMono Nerd Font Mono";
      };
    };
  };
}

