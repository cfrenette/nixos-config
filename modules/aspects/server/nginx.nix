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
  den.aspects.nginx-proxy = {
    includes = [ den.aspects.acme ];
    nixos = {
      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
      };

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];
    };
  };
}
