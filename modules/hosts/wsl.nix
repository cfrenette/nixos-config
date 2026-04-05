{ den, lib, ... }:
{
  flake-file.inputs.nixos-wsl = {
    url = "github:nix-community/nixos-wsl";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.hosts.x86_64-linux.wsl.wsl.enable = true;

  den.aspects.wsl = {
    includes = [
      den.aspects.stylix
      den.aspects.azure-cli
    ];
    provides.cory = {
      includes = [
        den.aspects.git._.work
      ];
    };
    nixos = {
      # INFO: Windows manages networking
      networking = {
        useDHCP = false;
        wireless.enable = lib.mkForce false;
      };
    };
  };
}
