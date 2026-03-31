{ den, inputs, ... }:
{
  flake-file.inputs.nixos-wsl = {
    url = "github:nix-community/nixos-wsl";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.wsl-nixos = {
    includes = [
      den.provides.hostname
      den.aspects.stylix
      den.aspects.azure-cli
    ];
    provides.cory = {
      includes = [
        den.aspects.git._.work
      ];
    };
    wsl.enable = true;
    nixos = {
      imports = [ inputs.nixos-wsl.nixosModules.default ];
      wsl = {
        enable = true;
        wslConf.automount.root = "/mnt";
      };
    };
  };
}
