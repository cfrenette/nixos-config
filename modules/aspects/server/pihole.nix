{ den, ... }:
{
  den.aspects.pihole = {
    includes = [
      den.aspects.sops
      den.aspects.nginx-proxy
    ];
    nixos =
      { config, ... }:
      {
        services.pihole-ftl = {
          enable = true;
          openFirewallDNS = true;
          # The dashboard is only reachable through reverse proxy
          openFirewallWebserver = false;

          settings = {
            dns = {
              upstreams = [
                "1.1.1.1"
                "1.0.0.1"
              ];
              # Answer on all interfaces for the local subnet.
              listeningMode = "LOCAL";
              # Resolve our own name locally: the public *.frenette.dev CNAME
              # points at the WAN address
              hosts = [
                "192.168.1.100 pihole.frenette.dev"
              ];
            };
            # Allow `pihole-FTL --config` style CLI reads of the API password.
            # Also required for `lists` below: pihole-ftl-setup loads them
            # through the web API.
            webserver.api.cli_pw = true;
          };

          lists = [
            {
              url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
              description = "StevenBlack unified: adware + malware";
            }
          ];
        };

        sops.secrets."pihole/web-password" = {
          owner = config.services.pihole-ftl.user;
          group = config.services.pihole-ftl.group;
          mode = "0400";
        };

        systemd.services.pihole-ftl.serviceConfig.EnvironmentFile =
          config.sops.secrets."pihole/web-password".path;

        services.pihole-web = {
          enable = true;
          hostName = "pihole.frenette.dev";
          ports = [ "127.0.0.1:8080" ];
        };

        services.nginx.virtualHosts."pihole.frenette.dev" = {
          forceSSL = true;
          useACMEHost = "frenette.dev";
          locations."/" = {
            proxyPass = "http://127.0.0.1:8080";
            proxyWebsockets = true;
          };
        };
      };
  };
}
