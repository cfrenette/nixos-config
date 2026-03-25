{ inputs, den, ... }:
{
  den.aspects.backups = {
    includes = [
      den.aspects.sops
    ];
    homeManager =
      { config, ... }:
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
            sopsFile = "${inputs.nix-secrets}/rclone.conf";
            path = "/home/cory/.config/rclone/rclone.conf";
          };
        };
      };
  };
}
