{ pkgs, config, lib, inputs, ... }:
let
  amdgpu-kernel-module = pkgs.callPackage ../../../patches/amdgpu.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];
  boot = {
    kernelPackages =
      let
        linux_6_12_pkg = { fetchurl, buildLinux, ... } @ args:
          buildLinux (args // rec {
            src = fetchurl {
              url = "https://git.kernel.org/torvalds/t/linux-6.12-rc6.tar.gz";
              sha256 = "sha256-eTJwO784WZMvYVwh3kxa5W2Z3IVSW8I2HVQyFs/35Mo=";
            };
            dontStrip = true;
            version = "6.12.0-rc6";
            modDirVersion = version;
          } // (args.argsOverride or { }));
        linux_6_12 = pkgs.callPackage linux_6_12_pkg { };
      in
      pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_6_12);

    # Patch AMDGPU for overlay planes bug
    extraModulePackages = [
      (amdgpu-kernel-module.overrideAttrs (_: {
        patches = [
          # ../../../patches/amdgpu_mst.patch
          ../../../patches/overlay-planes-patch_6-12-rc6.patch
        ];
      }))
    ];

    loader = {
      # Replaced by lanzaboote
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    bootspec.enable = true;
    lanzaboote = {
      enable = true;
      # Number of prior configurations to keep
      configurationLimit = 5;
      pkiBundle = "/etc/secureboot";
    };
  };
}

