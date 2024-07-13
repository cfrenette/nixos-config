{ pkgs, ... }:
{
  imports = [
    ./config.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./kanshi
    ./mako.nix
    ./rofi
    ./waybar
  ];

  home.packages = with pkgs; [
    wbg
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    systemd.enable = true;
  };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
}

