{ inputs, ... }:
{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
  };
}
