{
  den.aspects.nh = {
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        programs.nh = {
          enable = lib.mkDefault true;
          clean = {
            enable = lib.mkDefault true;
            extraArgs = lib.mkDefault "--keep-since 7d --keep 5";
          };
          flake = lib.mkDefault "${config.home.homeDirectory}/nix-config";
          osFlake = lib.mkDefault "${config.home.homeDirectory}/nix-config";
          homeFlake = lib.mkDefault "${config.home.homeDirectory}/nix-config";
        };
        home.packages =
          let
            nixe = pkgs.writeShellScriptBin "nixe" ''
              trap "cd \"''${PWD}\"" EXIT
              cd "$NH_FLAKE" && "$EDITOR"
            '';
          in
          with pkgs;
          [
            nix-output-monitor
            nvd
            nixe
          ];
        home.shellAliases = {
          nixc = "nh clean all";
          nixu = "nh os build --update";
          nixb = "nh os build";
          nixs = "nh os switch";
        };
      };
  };
}
