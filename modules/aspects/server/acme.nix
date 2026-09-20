{ den, ... }:
{
  den.aspects.acme = {
    includes = [ den.aspects.cloudflare-token ];
    nixos =
      { config, ... }:
      {
        security.acme = {
          acceptTerms = true;
          defaults.email = "cory@frenette.dev";

          # Let's Encrypt rate limits are per-week and unforgiving. Uncomment
          # to debug the full issuance path against staging

          # defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";

          certs."frenette.dev" = {
            extraDomainNames = [ "*.frenette.dev" ];
            dnsProvider = "cloudflare";
            credentialFiles.CF_DNS_API_TOKEN_FILE = config.sops.secrets."cloudflare/dns-token".path;
            dnsResolver = "1.1.1.1:53";
            group = "nginx";
          };
        };
      };
  };
}
