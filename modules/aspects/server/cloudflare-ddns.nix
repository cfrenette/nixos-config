{ den, ... }:
{
  den.aspects.cloudflare-ddns = {
    includes = [ den.aspects.cloudflare-token ];
    nixos =
      { config, ... }:
      {
        services.cloudflare-dyndns = {
          enable = true;
          apiTokenFile = config.sops.secrets."cloudflare/dns-token".path;
          domains = [ "home.frenette.dev" ];
          ipv4 = true;
          ipv6 = false;
          # DNS-only: the record must resolve to us for DNS-01 and LAN access.
          proxied = false;
        };

        systemd.services.cloudflare-dyndns = {
          after = [ "network-online.target" ];
          wants = [ "network-online.target" ];
        };
      };
  };

  den.aspects.cloudflare-token = {
    includes = [ den.aspects.sops ];
    nixos.sops.secrets."cloudflare/dns-token" = { };
  };
}
