{ inputs, ... }:
{
  flake-file.inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  den.aspects.hardware._.frmwrk = {
    nixos =
      {
        lib,
        config,
        modulesPath,
        ...
      }:
      {
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

        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        ];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/8df44455-d863-4dea-b470-af38b1ecfdc9";
          fsType = "ext4";
        };

        boot.initrd.luks.devices."luks-bf49a9f4-8c64-40d7-841e-f90331ce0c9b".device =
          "/dev/disk/by-uuid/bf49a9f4-8c64-40d7-841e-f90331ce0c9b";
        boot.initrd.luks.devices."luks-31f65682-658f-485f-b65d-c0495d68971d".device =
          "/dev/disk/by-uuid/31f65682-658f-485f-b65d-c0495d68971d";

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/5856-3A47";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };

        swapDevices = [ { device = "/dev/disk/by-uuid/fdd7cd38-e98c-44ab-b665-5e75bbad9d1a"; } ];

      };
  };
}
