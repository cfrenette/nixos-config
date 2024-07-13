{
  imports = [
    ./direnv.nix
  ];

  home = {
    shellAliases = import ./aliases.nix;
  };

  programs.bash.enable = true;
}

