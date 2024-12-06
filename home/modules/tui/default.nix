{ pkgs, ... }:
{
  imports = [
    ./nixvim
    ./shell
  ];

  home.packages = with pkgs; [
    ripgrep
  ];
}

