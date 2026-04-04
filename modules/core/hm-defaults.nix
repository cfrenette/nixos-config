{ den, lib, ... }:
{

  flake-file.inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.hm-defaults = {
    _.osConfig = den.lib.perHost {
      nixos.home-manager = {
        useUserPackages = lib.mkDefault true;
        useGlobalPkgs = lib.mkDefault true;
        backupFileExtension = lib.mkDefault "backup";
        overwriteBackup = lib.mkDefault true;
      };
    };
    _.hmConfig = {
      homeManager.home.stateVersion = lib.mkDefault "24.05";
    };
  };
}
