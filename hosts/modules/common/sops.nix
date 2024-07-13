{ inputs, pkgs, config, ... }:
let
  secrets = builtins.toString inputs.nix-secrets;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    # Decrypt Keys
    age = {
      keyFile = "/home/cory/.config/sops/age/keys.txt";
      sshKeyPaths = [ "/home/cory/.ssh/id_ed25519" ];
      # If the key doesn't exist in the age key file, 
      # generate one from the ssh key
      generateKey = true;
    };
    # Encrypted Secrets File Path
    defaultSopsFile = "${secrets}/secrets.yaml";
    # Encrypted Secret File Format
    defaultSopsFormat = "yaml";

    secrets = {
      "users/cory/passwd" = {
        # Decrypt to /run/secrets-for-users/
        neededForUsers = true;
      };
    };
  };

  # Required for SOPS to set password during activation
  users.mutableUsers = false;
  # Set the password
  users.users.cory.hashedPasswordFile = config.sops.secrets."users/cory/passwd".path;

  environment.systemPackages = with pkgs; [
    age
    sops
  ];

}

