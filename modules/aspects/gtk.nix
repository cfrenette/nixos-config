{
  den.aspects.gtk = {
    homeManager =
      { pkgs, config, ... }:
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
          gtk4.theme = config.gtk.theme;
          enable = true;
          iconTheme = {
            package = pkgs.adwaita-icon-theme;
            name = "Adwaita";
          };
        };
      };
  };
}
