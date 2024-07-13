{ inputs, pkgs, ... }:
let
  secrets = builtins.toString inputs.nix-secrets;
in
{
  home.packages = with pkgs; [
    mumble
  ];

  sops.secrets.mumble = {
    format = "binary";
    sopsFile = "${secrets}/mumble.p12";
    path = "/home/cory/.config/Mumble/mumble.p12";
  };

  # TODO: Mumble Config File (and certificate?)
  # home.file.".config/Mumble/Mumble.conf".text = "";
}

