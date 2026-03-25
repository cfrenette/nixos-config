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
      };
  };
}
