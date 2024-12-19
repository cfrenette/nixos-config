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
          #../../../patches/temp-revert-338567d1762/0001-revert-338567d1762-for-MST-temp-fix.patch
          ../../../patches/test-regression-fix/0003-drm-amd-display-Don-t-write-DP_MSTM_CTRL-after-LT.patch
          ../../../patches/test-regression-fix/0004-drm-amdgpu-display-Fix-pbn-kbps-Conversion.patch
          ../../../patches/test-regression-fix/0005-drm-amd-display-Resort-to-dc-to-Compute-Native-MST-B.patch
          ../../../patches/test-overlay-planes-pf-fix/0001-drm-amd-display-fix-page-fault-due-to-max-surface-de.patch
          ../../../patches/test-overlay-planes-pf-fix/0002-drm-amd-display-increase-MAX_SURFACES-to-the-value-s.patch
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

