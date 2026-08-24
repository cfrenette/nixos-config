{ den, ... }:
{
  den.aspects.ssh = {
    includes = [
      den.aspects.sops
    ];
    homeManager = {
      programs.ssh = {
        enable = true;

        enableDefaultConfig = false;

        settings = {
          # Replaces default values (enableDefaultConfig) which will be deprecated
          "*" = {
            ForwardAgent = false;
            AddKeysToAgent = "no";
            Compression = false;
            ServerAliveInterval = 0;
            ServerAliveCountMax = 3;
            HashKnownHosts = false;
            UserKnownHostsFile = "~/.ssh/known_hosts";
            ControlMaster = "no";
            ControlPath = "~/.ssh/master-%r@%n:%p";
            ControlPersist = "no";
          };
          "github.com:cfrenette" = {
            IdentitiesOnly = true;
            IdentityFile = [
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

      home.file.".ssh/id_ed25519.pub".text = "${builtins.readFile ./id_ed25519.pub}";
    };
  };
}
