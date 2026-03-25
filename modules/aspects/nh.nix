{ den, ... }:
{
  den.aspects.nh = den.lib.perUser {
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
        home.packages = with pkgs; [
          nix-output-monitor
          nvd
        ];
        home.shellAliases = {
          nixc = "nh clean all";
          nixu = "'nix flake update --flake $flake'";
          nixb = "nh os build";
          nixs = "nh os switch";
          nixe = "cd $FLAKE && nvim && cd -";
        };
      };
  };
}
