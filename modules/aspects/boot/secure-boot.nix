{ inputs, ... }:
{
  flake-file.inputs.lanzaboote = {
    url = "github:nix-community/lanzaboote/v1.1.0";
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
          lanzaboote = {
            enable = true;
            configurationLimit = 5;
            pkiBundle = "/var/lib/sbctl";
          };
        };
      };
  };
}
