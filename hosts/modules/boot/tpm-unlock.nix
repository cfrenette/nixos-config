{ pkgs, ... }:
{
  imports = [
    # Require Secure Boot for TPM unlock
    ./secure-boot.nix
  ];

  environment.systemPackages = with pkgs; [
    # For systemd-cryptenroll
    tpm2-tss
  ];

  # Enable TPM unlock of LUKS
  #
  # Keys must be enabled imperatively - e.g.
  # sudo systemd-cryptenroll --wipe-slot=tpm2 /dev/nvme0n1p2 --tpm2-device=auto --tpm2-pcrs=0+2+7+12
  security.tpm2.enable = true;

  # TPM kernel module must be enabled for initrd. Device driver is viewable via the command:
  # sudo systemd-cryptenroll --tpm2-device=list
  boot.initrd = {
    systemd.enable = true;
    systemd.enableTpm2 = true;

    kernelModules = [
      "tpm_crb"
    ];
  };

  # Add debug param to diagnose TPM2 problems
  boot.kernelParams = [ "debug" ];
}

