{ inputs, ... }:
{
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-secrets = {
      url = "git+ssh://git@github.com/cfrenette/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };
  den.aspects.sops = {
    nixos =
      { pkgs, config, ... }:
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
          defaultSopsFile = "${inputs.nix-secrets}/secrets.yaml";
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
      };
    homeManager =
      { config, pkgs, ... }:
      {
        imports = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        home.packages = [ pkgs.sops ];
        sops = {
          defaultSopsFile = "${inputs.nix-secrets}/secrets.yaml";
          age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        };
      };
  };
}
