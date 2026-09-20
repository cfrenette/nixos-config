{ den, ... }:
{
  # UGREEN NAS at 192.168.1.150. Pi-hole points viktor.frenette.dev at the Pi
  # (see pihole.nix) so this vhost can front it with the wildcard cert; the
  # NAS only has a self-signed one of its own.
  den.aspects.nas._.web = {
    includes = [ den.aspects.nginx-proxy ];
    nixos =
      { config, lib, ... }:
      {
        services.nginx.virtualHosts."viktor.frenette.dev" = {
          forceSSL = true;
          useACMEHost = "frenette.dev";
          # Pinned here rather than inherited: this vhost might serve an
          # unauthenticated file service and must not follow commonHttpConfig
          # if that ever opens up.
          extraConfig = ''
            allow 192.168.1.0/24;
            allow 127.0.0.1;
            deny all;
          '';
          locations."/" = {
            proxyPass = "https://192.168.1.150:9443";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_ssl_verify off;
              proxy_redirect https://192.168.1.150:9443/ https://viktor.frenette.dev/;
            '';
          };
        };

        assertions = [
          {
            assertion =
              !lib.hasInfix "allow all" config.services.nginx.virtualHosts."viktor.frenette.dev".extraConfig;
            message = "nas._.web: viktor.frenette.dev must stay LAN-only; it proxies an unauthenticated file manager.";
          }
        ];
      };
  };
}
