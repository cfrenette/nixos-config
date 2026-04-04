{ den, ... }:
{
  den.aspects.frmwrk = {
    includes = [
      den.aspects.sops
      den.aspects.hardware._.frmwrk
      den.aspects.laptop
      den.aspects.tpm-unlock
      den.aspects.cosmic
      den.aspects.qmk
      den.aspects.stylix
      den.aspects.sound
      den.aspects.nixvim
    ];
    # host-specfic HM config
    provides.cory = {
      includes = [
        den.aspects.sops
        den.aspects.ssh
        den.aspects.backups
        den.aspects.mumble
        den.aspects.git._.home
        den.aspects.gui
      ];
    };
    nixos =
      { pkgs, ... }:
      {
        nixpkgs.config.allowUnfree = true;
        networking.networkmanager.enable = true;

        environment.systemPackages = with pkgs; [
          brightnessctl
          # TODO: remove these, used in bootstrapping
          p7zip
          wget
        ];

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

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
        services.logind.settings.Login.HandlePowerKey = "suspend";

      };
  };
}
