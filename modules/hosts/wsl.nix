{ den, ... }:
{
  flake-file.inputs.nixos-wsl = {
    url = "github:nix-community/nixos-wsl";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-compat.follows = "";
  };

  den.aspects.wsl = {
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
    wsl.defaultUser = "cory";
    nixos =
      { pkgs, ... }:
      {
        fileSystems."/".device = "/dev/noroot";
        boot.loader.grub.enable = false;
        environment.systemPackages = with pkgs; [
          p7zip
        ];
      };
  };
}
