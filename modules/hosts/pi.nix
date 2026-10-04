{ den, lib, ... }:
{
  # Raspberry Pi 3B+, headless. Deployed from a host with binfmt._.aarch64:
  # nixs -H pi --target-host root@192.168.1.100
  # otherwise add --build-host root@192.168.1.100
  den.aspects.pi = {
    includes = [
      den.aspects.sops._.hostKey
      den.aspects.hardware._.pi
      den.aspects.cloudflare-ddns
      den.aspects.nginx-proxy
      den.aspects.pihole
      den.aspects.nas._.web
    ];

    nixos = {
      nixpkgs.config.allowUnfree = true;

      networking = {
        useDHCP = false;
        interfaces.enu1u1u1.ipv4.addresses = [
          {
            address = "192.168.1.100";
            prefixLength = 24;
          }
        ];
        defaultGateway = "192.168.1.1";

        # Pi is the nameserver
        nameservers = [ "127.0.0.1" ];

        networkmanager.enable = lib.mkForce false;

        # extraCommands runs after the allowedTCPPorts accepts and before the
        # final refuse, so a port must be out of that list for a
        # source-restricted rule to ever be reached.
        firewall.extraCommands = ''
          iptables -w -A nixos-fw -p tcp --dport 22 -s 192.168.1.0/24 -j nixos-fw-accept
        '';
      };

      # Pi-hole binds :53. resolved would take it first.
      services.resolved.enable = false;

      services.journald.settings.Journal.SystemMaxUse = "100M";

      services.openssh = {
        enable = true;
        # LAN-only; see networking.firewall.extraCommands above.
        openFirewall = false;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "prohibit-password";
        };
      };
      users.users.root.openssh.authorizedKeys.keyFiles = [ ../id_ed25519.pub ];

      nix.settings = {
        max-jobs = 1;
        cores = 2;
      };

      boot.loader.generic-extlinux-compatible.configurationLimit = 3;

      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep 3";
        };
      };

      system.stateVersion = "25.11";
    };
  };
}
