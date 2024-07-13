{ pkgs, ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    # FIXME:
    # Not yet available in 24.05 stable
    # https://github.com/nix-community/nixvim/pull/1655
    # inlayHints = true;

    keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lspBuf = {
        "K" = "hover";
        "gd" = "definition";
        "gD" = "references";
        "gi" = "implementation";
        "gt" = "type_definition";
        "<M-CR>" = "code_action";
      };
    };

    servers = {
      nixd = {
        enable = true;
        settings.formatting.command = [ "nixpkgs-fmt" ];
      };
      bashls.enable = true;
      rust-analyzer = {
        enable = true;
      };
      tsserver.enable = true;
      yamlls.enable = true;
    };
  };

  # NOTE: This setup won't work for rustup installed toolchains
  # most projects will want to use a nix shell 
  # (https://nixos.wiki/wiki/Rust#Installation_via_rustup)
  # and pick up cargo / rustanalyzer from ENV
  home.packages = with pkgs; [
    cargo
    rustc
  ];
}

