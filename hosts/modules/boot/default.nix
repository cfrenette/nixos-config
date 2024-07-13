{
  imports = [
    ./tpm-unlock.nix
  ];
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = [ "kvm-amd" ];
  };
}

