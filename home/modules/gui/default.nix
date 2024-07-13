{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./gtk.nix
    ./mumble.nix
    ./hyprland
  ];

  home.packages = with pkgs; [
    bitwarden-desktop
    ffmpeg
    # Community-packaged Discord
    vesktop
  ];

  stylix.targets.vesktop.enable = true;
}

