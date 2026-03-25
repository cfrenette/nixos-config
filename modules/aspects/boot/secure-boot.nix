{ inputs, ... }:
{
  flake-file.inputs.lanzaboote = {
    url = "github:nix-community/lanzaboote/v0.4.3";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  den.aspects.secure-boot = {
    nixos =
      { pkgs, lib, ... }:
      {
        imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
        boot = {
          kernelPackages = pkgs.linuxPackages_6_18;
          loader = {
            systemd-boot.enable = lib.mkForce false;
            efi.canTouchEfiVariables = true;
          };
          bootspec.enable = true;
          lanzaboote = {
            enable = true;
            configurationLimit = 5;
            pkiBundle = "/etc/secureboot";
          };
        };
      };
  };
}
