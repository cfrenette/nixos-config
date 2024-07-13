{
  # Allow Signing with SSH Key
  home.file.".ssh/allowed_signers".text = "cory@frenette.dev ${builtins.readFile ./keys/id_ed25519.pub}";

  programs.git = {
    enable = true;

    userName = "Cory Frenette";
    userEmail = "cory@frenette.dev";

    extraConfig = {
      # Configure SSH Signing
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "/home/cory/.ssh/allowed_signers";
      user.signingKey = "/home/cory/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
    };
  };

  sops.secrets = {
    "users/cory/pgp" = {
      path = "/home/cory/.ssh/pgp_private.asc";
    };
  };
}

