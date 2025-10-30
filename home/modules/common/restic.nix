{
  inputs,
  config,
  osConfig,
  ...
}:
let
  secrets = builtins.toString inputs.nix-secrets;
in
{
  services.restic = {
    enable = true;
    backups = {
      google-drive = {
        repository = "rclone:google-drive:/backups";
        initialize = true;
        passwordFile = config.sops.secrets."users/cory/restic".path;
        paths = [ "/home/cory" ];
        extraBackupArgs = [ "--exclude=/home/cory/nix-config" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };
    };
  };
  sops.secrets = {
    "users/cory/restic" = { };
    rclone = {
      format = "binary";
      sopsFile = "${secrets}/rclone.conf";
      path = "/home/cory/.config/rclone/rclone.conf";
    };
  };
}
