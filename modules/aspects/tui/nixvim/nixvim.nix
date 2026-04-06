{ inputs, den, ... }:
{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
  };
  den.aspects.nixvim = {
    includes = [ den.aspects.nixvim._.core ];
    _.core = {
      includes = with den.aspects.nixvim._; [
        cmp
        colorscheme-gruvboxMaterial
        conform
        lsp
        lualine
        options
        telescope
        treesitter
        languages._.bash
        languages._.nix
      ];
    };
    homeManager = {

      imports = [ inputs.nixvim.homeModules.nixvim ];

      stylix.targets.nixvim.enable = false;

      programs.nixvim = {
        enable = true;
        clipboard.providers.wl-copy.enable = true;
        viAlias = true;
        vimAlias = true;
      };

      home.sessionVariables = {
        EDITOR = "nvim";
      };
    };
  };
}
