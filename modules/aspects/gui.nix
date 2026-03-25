{ den, ... }:
{
  den.aspects.gui = {
    includes = [
      den.aspects.alacritty
      den.aspects.firefox
      den.aspects.gtk
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          bitwarden-desktop
          google-chrome
          ffmpeg
          vesktop
        ];
        home.sessionVariables = {
          NIXOS_OZONE_WL = "1";
        };
      };
  };
}
