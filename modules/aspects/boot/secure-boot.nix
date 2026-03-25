{ inputs, ... }:
{
  den.aspects.secure-boot = {
    nixos =
      { pkgs, lib, ... }:
      {
        imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
        boot = {
          kernelPackages = lib.mkForce pkgs.linuxPackages_6_18;
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
