{ inputs, ... }:
{
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-file.url = "github:vic/flake-file";
    den.url = "github:cfrenette/den/development/wsl-bug";
  };
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];
}
