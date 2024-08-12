{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./gtk.nix
    #./hyprland
    ./mumble.nix
    ./stylix.nix
  ];

  home.packages = with pkgs; [
    bitwarden-desktop
    fractal
    ffmpeg
    # Community-packaged Discord
    vesktop
  ];
}

