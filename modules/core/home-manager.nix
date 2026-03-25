{ den, lib, ... }:
{

  flake-file.inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Default Home Manager Settings
  den.ctx.hm-host.includes = [ den.aspects.home-manager._.osConfig ];
  den.ctx.hm-user.includes = [ den.aspects.home-manager._.hmConfig ];

  den.aspects.home-manager = {
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
