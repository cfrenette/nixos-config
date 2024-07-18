{
  stylix = {
    enable = true;
  };

  home-manager.sharedModules = [{
    stylix.targets.nixvim.enable = false;
  }];
}

