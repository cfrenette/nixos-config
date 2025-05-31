{ inputs, system, ... }:
{
  home.packages = [
    inputs.nixvim.packages.${system}.default
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
