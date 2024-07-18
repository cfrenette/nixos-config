{ ... }:
{
  imports = [
    ../modules/common/wsl.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  wsl.defaultUser = "cory";

  # Set hostname
  networking.hostName = "wsl";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";

}
