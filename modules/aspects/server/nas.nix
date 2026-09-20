{ den, ... }:
{
  # UGREEN NAS at 192.168.1.150. Pi-hole points viktor.frenette.dev at the Pi
  # (see pihole.nix) so this vhost can front it with the wildcard cert; the
  # NAS only has a self-signed one of its own.
  den.aspects.nas = {
    includes = [ den.aspects.nginx-proxy ];
    nixos = {
      services.nginx.virtualHosts."viktor.frenette.dev" = {
        forceSSL = true;
        useACMEHost = "frenette.dev";
        locations."/" = {
          proxyPass = "https://192.168.1.150:9443";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_ssl_verify off;
            proxy_redirect https://192.168.1.150:9443/ https://viktor.frenette.dev/;
          '';
        };
      };
    };
  };
}
