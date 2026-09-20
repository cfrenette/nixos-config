{ den, lib, ... }:
{
  # Raspberry Pi 3B+, headless. Deployed from another host with:
  #   nixos-rebuild switch --flake .#pi \
  #     --target-host root@192.168.1.100 --build-host root@192.168.1.100
  den.aspects.pi = {
    includes = [
      den.aspects.sops._.hostKey
      den.aspects.hardware._.pi
      den.aspects.cloudflare-ddns
      den.aspects.nginx-proxy
      den.aspects.pihole
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
      };

      # Pi-hole binds :53. resolved would take it first.
      services.resolved.enable = false;

      services.openssh = {
        enable = true;
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

      system.stateVersion = "25.11";
    };
  };
}
