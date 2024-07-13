# Secure Boot Disabled
# TPM Disabled
# Used after initial install to bootstrap device state:
#
# Enable Secure Boot:
#
# 1. $ sudo nix run nixpkgs#sbctl create-keys
# 2. uncomment secure boot import
# 3. rebuild / switch and verify:
#       $ sudo nix run nixpkgs#sbctl verify
#       Verifying file database and EFI images in /boot...
#       ✓ /boot/EFI/BOOT/BOOTX64.EFI is signed
#       ✓ /boot/EFI/Linux/nixos-generation-414-376jna572gsb23snqs67t7s4bwxzb3epblmdnzweghuepopml2va.efi is signed
#       ✓ /boot/EFI/Linux/nixos-generation-415-iqulgohymbdppgtxzho6ou3fcuxjbxhumpzm4vojmipwy3sbmuna.efi is signed
#       ✓ /boot/EFI/Linux/nixos-generation-416-kxnzioafnduwwck3oypo7rqwtoat745czp2bpehoufp4yqiawypa.efi is signed
#       ✗ /boot/EFI/nixos/kernel-6.8.2-242idodyvf36cpl6s5dskjy6mo4tjhszuwa3hye7qcjyuo5vnehq.efi is not signed
#       ✗ /boot/EFI/nixos/kernel-6.8.5-zqulrwsucm6okcyns6v2jhh6fregk3bvsdth3yloqfymfbgnh64a.efi is not signed
#       ✗ /boot/EFI/nixos/kernel-6.8.7-6mmixkr6ewywm5swgbi5ethbpgnyia4borzmkevcjx7n7t3mtida.efi is not signed
#       ✓ /boot/EFI/systemd/systemd-bootx64.efi is signed
# 4. reboot to UEFI, clear any existing keys and enable
#
# Enroll Secure Boot Keys
#
# 1. $ sudo nix run nixpkgs#sbctl enroll-keys -- --microsoft
# 2. reboot and verify:
#       $ bootctl status
#       System:
#             Firmware: UEFI 2.80 (American Megatrends 5.26)
#        Firmware Arch: x64
#          Secure Boot: enabled (user)
#         TPM2 Support: yes
#         Boot into FW: supported
#
# Enable TPM unlock
#
# 1. switch from bootstrap.nix to default.nix, rebuild / switch (install tpm-tss system package)
# 2. for each LUKS partition to be decrypted:
#       $ sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+7+12 --wipe-slot=tpm2 /dev/nvme0n1pX
#

{ pkgs, ... }:
{
  # imports = [
  #    ./secure-boot.nix
  # ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      # number of configurations to keep
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };
  };
}

