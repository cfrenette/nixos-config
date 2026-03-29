{ den, ... }:
{
  den.aspects.git = {
    homeManager = {
      programs.git = {
        enable = true;
        signing.format = "openpgp";
        settings = {
          user.name = "Cory Frenette";
          commit.gpgsign = true;
          init.defaultBranch = "main";
        };
      };
    };
    _.home = {
      includes = [
        den.aspects.sops
        den.aspects.git
      ];
      homeManager =
        { pkgs, config, ... }:
        {
          # Allow Signing with SSH Key
          home.file.".ssh/allowed_signers".text = "cory@frenette.dev ${builtins.readFile ./id_ed25519.pub}";

          programs.git = {
            settings = {
              # Configure SSH Signing
              gpg.format = "ssh";
              gpg.ssh.allowedSignersFile = "/home/cory/.ssh/allowed_signers";
              user = {
                email = "cory@frenette.dev";
                signingKey = "/home/cory/.ssh/id_ed25519.pub";
              };
              # Sendemail
              sendemail.sendmailCmd = "${pkgs.msmtp}/bin/sendmail";
            };
            package = pkgs.gitFull;

          };

          # Sendmail
          programs.msmtp = {
            enable = true;
          };

          # Configure Sendmail
          accounts.email.accounts.cory = {
            msmtp.enable = true;
            primary = true;
            realName = "Cory Frenette";
            smtp = {
              tls = {
                enable = true;
                useStartTls = false;
              };
              host = "smtp.gmail.com";
            };
            address = "cory@frenette.dev";
            userName = "frenette.cory@gmail.com";
            passwordCommand = "cat ${config.sops.secrets."users/cory/gmail".path}";
          };

          sops.secrets = {
            "users/cory/pgp" = {
              path = "/home/cory/.ssh/pgp_private.asc";
            };
            "users/cory/gmail" = { };
          };
        };
    };
    _.work = {
      includes = [
        den.aspects.git
      ];
      homeManager =
        { pkgs, ... }:
        {
          programs.git = {
            settings = {
              gpg.format = "openpgp";
              user = {
                email = "coryfrenette@montrose-env.com";
                signingKey = "93996586B9AD42F5EB0B171F69DD71398B944D85";
              };
            };
          };
          services.gpg-agent = {
            enable = true;
            noAllowExternalCache = true;
            verbose = true;
            pinentry.package = pkgs.pinentry-tty;
          };
          home.packages = [ pkgs.pinentry-tty ];
        };
    };
  };
}
