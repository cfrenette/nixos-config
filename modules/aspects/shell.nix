{
  den.aspects.shell = {
    homeManager = {
      programs.bash.enable = true;
      # TODO: Move these into nh
      home.shellAliases = {
        nixgc = "nh clean all --keep 5";
        nixu = "'nix flake update --flake $flake'";
        nixb = "nh os build";
        nixs = "nh os switch";
        nixe = "cd $FLAKE && nvim && cd -";
      };
    };
  };
}
