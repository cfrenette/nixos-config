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
          ../../../patches/temp-revert-338567d1762/0001-revert-338567d1762-for-MST-temp-fix.patch
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

