{ pkgs, config, ... }:
{
  # Allow Signing with SSH Key
  home.file.".ssh/allowed_signers".text =
    "cory@frenette.dev ${builtins.readFile ./keys/id_ed25519.pub}";

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Cory Frenette";
        email = "cory@frenette.dev";
      };
      # Configure SSH Signing
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "/home/cory/.ssh/allowed_signers";
      user.signingKey = "/home/cory/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
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
}
