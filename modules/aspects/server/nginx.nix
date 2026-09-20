{ den, ... }:
{
  # Reverse proxy terminating TLS with the *.frenette.dev wildcard cert.
  # Backends declare their own vhost alongside the service, e.g.
  #
  #   services.nginx.virtualHosts."pihole.frenette.dev" = {
  #     forceSSL = true;
  #     useACMEHost = "frenette.dev";
  #     locations."/".proxyPass = "http://127.0.0.1:8080";
  #   };
  #
  # Vhosts are LAN-only unless they opt out with `extraConfig = "allow all;"`.
  den.aspects.nginx-proxy = {
    includes = [ den.aspects.acme ];
    nixos = {
      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;

        # Unmatched Host/SNI must not fall through to the first real vhost.
        virtualHosts."_" = {
          default = true;
          rejectSSL = true;
          extraConfig = "return 444;";
        };

        commonHttpConfig = ''
          limit_req_zone $binary_remote_addr zone=perip:1m rate=10r/s;
          limit_req zone=perip burst=20 nodelay;

          allow 192.168.1.0/24;
          allow 127.0.0.1;
          deny all;
        '';
      };

      systemd.services.nginx.serviceConfig.MemoryMax = "256M";

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];
    };
  };
}
