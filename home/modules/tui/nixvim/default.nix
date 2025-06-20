{
  inputs,
  system,
  pkgs,
  ...
}:
let
  extensions = import ./extensions;
  nixvim = inputs.nixvim.packages.${system}.default.extend extensions;
in
{

  home.packages = [
    nixvim
    pkgs.beautysh
    pkgs.nixfmt-rfc-style
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
