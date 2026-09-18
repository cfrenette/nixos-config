{ den, inputs, ... }:
{
  flake-file.inputs.opencode-pr = {
    url = "github:NixOS/nixpkgs/pull/564101/head";
  };
  den.aspects.opencode = {
    nixos.nixpkgs.overlays = [
      (final: prev: {
        opencode = final.callPackage "${inputs.opencode-pr}/pkgs/by-name/op/opencode/package.nix" { };
      })
    ];
    homeManager = {
      programs.opencode = {
        enable = true;
        settings = {
          "$schema" = "https://opencode.ai/config.json";
          plugin = [ "@ex-machina/opencode-anthropic-auth@1.8.4" ];
          lsp = { };
          disabled_providers = [ "opencode" ];
        };
      };
    };
  };
}
