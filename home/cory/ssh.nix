{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    matchBlocks = {
      # Replaces default values (enableDefaultConfig) which will be deprecated
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
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
