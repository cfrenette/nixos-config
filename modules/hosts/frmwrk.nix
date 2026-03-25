{ den, inputs, ... }:
{
  den.hosts.x86_64-linux.frmwrk.users.cory = { };
  den.aspects.frmwrk = {
    includes = [
      den.provides.hostname
      den.aspects.sops
      den.aspects.frmwrk-hardware
      den.aspects.laptop
      den.aspects.tpm-unlock
      den.aspects.cosmic
      den.aspects.qmk
      den.aspects.stylix
      den.aspects.sound
      den.aspects.nixvim
    ];
    nixos =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = [
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        ];

        nixpkgs.config.allowUnfree = true;
        networking.networkmanager.enable = true;

        boot = {
          kernelModules = [ "kvm-amd" ];
          initrd.availableKernelModules = [
            "nvme"
            "xhci_pci"
            "thunderbolt"
            "usb_storage"
            "sd_mod"
          ];
          kernelParams = [ "boot.shell_on_fail" ];
          loader.timeout = 0;
        };

        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

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
