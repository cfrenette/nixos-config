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
            initialize = true;
            # initialize would otherwise create a fresh local repo on the root
            # filesystem if the automount is ever stopped, and back up into it
            # silently. Fail the unit instead. `mountpoint -q` is not enough:
            # the autofs placeholder satisfies it without triggering the real
            # mount, so read the directory to trigger it and then insist on an
            # actual cifs filesystem being there.
            backupPrepareCommand = ''
              ${pkgs.coreutils}/bin/ls /mnt/nas/${user.userName}/ >/dev/null 2>&1 || true
              ${pkgs.util-linux}/bin/findmnt -n -t cifs --mountpoint /mnt/nas/${user.userName} >/dev/null
            '';
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

          # `Persistent` fires the missed run at login, which on a laptop is
          # before Wi-Fi is up, so the first attempt fails. Retry every 15
          # minutes for up to ~90 minutes.
          systemd.user.services.restic-backups-nas = {
            Unit = {
              OnFailure = [ "restic-failed.service" ];
              StartLimitIntervalSec = "3h";
              StartLimitBurst = 6;
            };
            Service = {
              Restart = "on-failure";
              RestartSec = "15min";
            };
          };
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
