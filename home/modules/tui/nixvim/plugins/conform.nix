{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      nix = [ "nixpkgs-fmt" ];
      rust = [ "rustfmt" ];
    };
    formatOnSave = {
      lspFallback = true;
      timeoutMs = 500;
    };
  };
}

