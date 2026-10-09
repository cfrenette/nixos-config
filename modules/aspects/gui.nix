{ den, ... }:
{
  den.aspects.gui = {
    includes = [
      den.aspects.alacritty
      den.aspects.firefox
      den.aspects.gtk
      den.aspects.vesktop
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          bitwarden-desktop
          ffmpeg
        ];
        home.sessionVariables = {
          NIXOS_OZONE_WL = "1";
        };
      };
  };
}
