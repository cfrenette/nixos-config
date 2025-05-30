{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.intone-mono
    nerd-fonts.fira-mono
  ];
}

