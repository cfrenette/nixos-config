{ inputs, ... }:
let
  secrets = builtins.toString inputs.nix-secrets;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = "${secrets}/secrets.yaml";
    age.keyFile = "/home/cory/.config/sops/age/keys.txt";
  };
}

