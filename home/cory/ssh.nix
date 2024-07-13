{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "GitHub" = {
        host = "github.com:cfrenette";
        identitiesOnly = true;
        identityFile = [
          "/home/cory/.ssh/id_ed25519"
        ];
      };
    };
  };

  sops.secrets = {
    "users/cory/ssh" = {
      path = "/home/cory/.ssh/id_ed25519";
    };
  };

  home.file.".ssh/id_ed25519.pub".text = "${builtins.readFile ./keys/id_ed25519.pub}";
}

