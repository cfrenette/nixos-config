{ inputs, ... }:
{
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/cda48547b432e8d3b18b4180ba07473762ec8558";
    flake-file.url = "github:vic/flake-file";
    den.url = "github:vic/den";
    flake-aspects.url = "github:vic/flake-aspects";
  };
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];
}
