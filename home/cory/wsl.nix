{ ... }:
{
  imports = [
    ../modules/common/fonts.nix
    ../modules/tui
  ];

  # Enable Home Manager
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    # TODO: configure signing
  };

  # The managed user
  home = {
    username = "cory";
    homeDirectory = "/home/cory";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
