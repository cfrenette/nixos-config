{ den, ... }:
{
  # UGREEN NAS at 192.168.1.150, reached as nas.frenette.dev (a dns.hosts entry
  # on the Pi pointing straight at the NAS -- the Pi is not in the data path).
  #
  # The static `nas` body is reserved for config common to every consumer, such
  # as a future cross-user shared mount. Per-user config belongs in `_.personal`
  # so it is emitted once per user rather than once per host.
  den.aspects.nas = { };

  den.aspects.nas._.personal =
    { user, ... }:
    {
      includes = [ den.aspects.sops ];
      nixos =
        { config, ... }:
        {
          sops.secrets."users/${user.userName}/nas-smb" = { };

          boot.supportedFilesystems.cifs = true;

          # Outside the home directory on purpose: a mount under ~ would sit
          # inside restic's backup path and the repo would back itself up.
          fileSystems."/mnt/nas/${user.userName}" = {
            device = "//nas.frenette.dev/personal_folder";
            fsType = "cifs";
            options = [
              "credentials=${config.sops.secrets."users/${user.userName}/nas-smb".path}"
              "uid=${user.userName}"
              "gid=users"
              "vers=3.1.1"
              "seal"
              # Lazily attached, so a laptop away from the LAN boots cleanly
              "noauto"
              "x-systemd.automount"
              "_netdev"
              "x-systemd.idle-timeout=600"
              "x-systemd.mount-timeout=10"
            ];
          };
        };

      # Convenience path for interactive use.
      homeManager =
        { config, ... }:
        {
          home.file."nas".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nas/${user.userName}";
        };
    };
}
