{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        nix = [ "nixpkgs-fmt" ];
        rust = [ "rustfmt" ];
      };
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
    };
  };
}

