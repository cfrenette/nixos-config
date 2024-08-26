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
    google-chrome
    fractal
    ffmpeg
    mattermost-desktop
    # Community-packaged Discord
    vesktop
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}

