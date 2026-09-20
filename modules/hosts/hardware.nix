{ inputs, ... }:
{
  flake-file.inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  # Framework Laptop 13 AMD 7040U
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

  # Raspberry Pi 3B+
  den.aspects.hardware._.pi = {
    nixos =
      { pkgs, lib, ... }:
      {
        imports = [
          inputs.nixos-hardware.nixosModules.raspberry-pi-3
        ];

        # Use mainline kernel to avoid the native compile
        boot.kernelPackages = pkgs.linuxPackages;

        # Needed for USB with the mainline kernel
        boot.loader.generic-extlinux-compatible.useGenerationDeviceTree = true;

        hardware.raspberry-pi.firmware = {
          enable = true;
          uboot.enable = true;

          # The stock SD image's firmware partition is only 30MiB, and all of
          # raspberrypifw (every start*.elf variant, every board's DTB) does
          # not fit next to u-boot.bin. A 3B+ at default gpu_mem with no
          # camera loads only these: start4* is Pi 4, start_x is
          # camera/codec, start_cd is gpu_mem<=16, start_db is debug.
          #
          # Re-add the matching start_*.elf/fixup_*.dat pair before lowering
          # gpu_mem or enabling the camera.
          package = pkgs.runCommand "raspberrypi-firmware-rpi3bplus" { } ''
            src=${pkgs.raspberrypifw}/share/raspberrypi/boot
            dst=$out/share/raspberrypi/boot
            mkdir -p $dst
            cp $src/bootcode.bin $src/start.elf $src/fixup.dat $dst/
            cp $src/bcm2710-rpi-3-b-plus.dtb $dst/
            cp -r $src/overlays $dst/
          '';
        };

        hardware.raspberry-pi.configtxt = {
          deviceTreeOverlays.all = lib.mkForce [ ];

          settings.all = {
            # Firmware low-voltage/overtemperature warnings corrupt the
            # framebuffer the mainline kernel set up.
            avoid_warnings = true;
            # Display/camera autodetection is pointless headless
            camera_auto_detect = lib.mkForce null;
            display_auto_detect = lib.mkForce null;
            disable_fw_kms_setup = lib.mkForce null;
            max_framebuffers = lib.mkForce null;
          };
          # Otherwise serial console output is garbled.
          settings.pi3.core_freq = 250;
        };

        # Labels come from the stock aarch64 SD installer image
        fileSystems = {
          "/" = {
            device = "/dev/disk/by-label/NIXOS_SD";
            fsType = "ext4";
          };
          "/boot/firmware" = {
            device = "/dev/disk/by-label/FIRMWARE";
            fsType = "vfat";
            options = [ "nofail" ];
          };
        };

        # 1GB of RAM is not enough to build
        zramSwap.enable = true;
        swapDevices = [
          {
            device = "/var/swapfile";
            size = 4096;
          }
        ];
      };
  };
}
