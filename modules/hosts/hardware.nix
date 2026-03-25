{
  den.aspects.frmwrk-hardware = {
    nixos =
      { modulesPath, ... }:
      {

        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
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
