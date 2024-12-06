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
    kernelPackages = pkgs.linuxPackages_6_12;

    # Patch AMDGPU for overlay planes bug
    extraModulePackages = [
      (amdgpu-kernel-module.overrideAttrs (_: {
        patches = [
          ../../../patches/temp-revert-338567d1762/mst-patch_6-12-rc6.patch
          ../../../patches/temp-fix-amdgpu-issue-3693/overlay-planes-patch_6-12-rc6.patch
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

