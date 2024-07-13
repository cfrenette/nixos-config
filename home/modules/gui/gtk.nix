{ pkgs, ... }:
{
  dconf.settings = {
    # "org/gnome/shell" = { favorite-apps = [ "firefox.desktop" "alacritty.desktop" ]; };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
  };

  # TODO: Replace
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}

