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
    clipboard.providers.wl-copy.enable = true;

    viAlias = true;
    vimAlias = true;
  };
}
