{
  nixgc = "nh clean all --keep 5";
  nixu = "'nix flake update --flake $FLAKE'";
  nixb = "nh os build";
  nixs = "nh os switch";
  nixe = "cd $FLAKE && nvim && cd -";
}

