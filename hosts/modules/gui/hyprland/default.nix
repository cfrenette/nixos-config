{ pkgs, config, ... }:
let
  waylandSessions = "${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions";
in
{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t --remember --remember-user-session -s ${waylandSessions}";
        user = "greeter";
      };
    };
  };

  security.pam.services.hyprlock = { };
}

