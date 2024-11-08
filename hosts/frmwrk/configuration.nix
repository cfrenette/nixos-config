{ config, pkgs, inputs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ../modules/common
    ../modules/gui
    ../modules/boot
    ../modules/sound
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set hostname
  networking.hostName = "frmwrk";

  # Enable Thunderbolt Daemon
  services.hardware.bolt.enable = true;

  # Enable Bluetooth Support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable MDNS
  services.avahi = {
    enable = true;
  };

  # Enable PPD (power profiles)
  services.power-profiles-daemon.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable firmware update daemon
  services.fwupd.enable = true;

  # Power button behavior 
  services.logind.powerKey = "suspend";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";

}
