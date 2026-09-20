{ den, ... }:
{
  # Restic to the NAS. The repository is encrypted client-side, so the NAS only
  # ever holds ciphertext; its own firewall keeps SMB to the LAN.
  #
  # Parameterized by host and user, so adding this aspect to another host's
  # provides.<user> is the whole change needed: the repo path follows.
  den.aspects.backups =
    { host, user, ... }:
    {
      includes = [
        den.aspects.sops
        den.aspects.nas._.personal
      ];
      homeManager =
        { config, pkgs, ... }:
        {
          services.restic.enable = true;
          services.restic.backups.nas = {
            repository = "/mnt/nas/${user.userName}/backups/${host.name}";
            # Repo is created by hand; see AGENTS.md.
            initialize = false;
            passwordFile = config.sops.secrets."users/${user.userName}/restic".path;
            paths = [ config.home.homeDirectory ];
            extraBackupArgs = [
              "--exclude=${config.home.homeDirectory}/nix-config"
              "--exclude-caches"
            ];
            pruneOpts = [
              "--keep-daily 7"
              "--keep-weekly 4"
              "--keep-monthly 6"
            ];
            runCheck = true;
            checkOpts = [ "--read-data-subset=5%" ];
            timerConfig = {
              OnCalendar = "daily";
              Persistent = true;
            };
          };

          sops.secrets."users/${user.userName}/restic" = { };

          # A user timer that fails is otherwise completely silent.
          systemd.user.services.restic-backups-nas.Unit.OnFailure = [ "restic-failed.service" ];
          systemd.user.services.restic-failed = {
            Unit.Description = "Notify that the restic backup failed";
            Service = {
              Type = "oneshot";
              ExecStart = "${pkgs.libnotify}/bin/notify-send --urgency=critical 'Backup failed' 'restic-backups-nas: see journalctl --user -u restic-backups-nas'";
            };
          };
        };
    };
}
