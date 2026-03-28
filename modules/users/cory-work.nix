{ den, ... }:
{
  den.aspects.cory-work = {
    includes = [
      den.aspects.git._.work
      den.aspects.fonts
      den.aspects.tui
    ];
    nixos = {
      users.users.cory = {
        isNormalUser = true;
        description = "Cory Frenette";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };
    homeManager = {
      home = {
        username = "cory";
        homeDirectory = "/home/cory";
      };
    };
  };
}
