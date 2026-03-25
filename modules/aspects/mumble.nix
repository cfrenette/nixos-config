{ inputs, den, ... }:
{
  den.aspects.mumble = {
    includes = [
      den.aspects.sops
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          mumble
        ];

        sops.secrets.mumble = {
          format = "binary";
          sopsFile = "${inputs.nix-secrets}/mumble.p12";
          path = "/home/cory/.config/Mumble/mumble.p12";
        };

        # TODO: Mumble Config File (and certificate?)
        # home.file.".config/Mumble/Mumble.conf".text = "";
      };
  };
}
