{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 5";
    };
    flake = "/home/cory/nix-config";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}

