{ pkgs, ... }:
{
  imports = [
    ./nh.nix
  ];

  # Allow Proprietary
  nixpkgs.config.allowUnfree = true;

  # Enable Networking
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/New_York";

  # Localization
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    p7zip
    wget
  ];

  # User configuration
  users.users.cory = {
    isNormalUser = true;
    description = "Cory Frenette";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;

}

