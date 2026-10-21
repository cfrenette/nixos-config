{ den, ... }:
{
  den.aspects.opencode = {
    homeManager = {
      programs.opencode = {
        enable = true;
        settings = {
          "$schema" = "https://opencode.ai/config.json";
          plugin = [ "@ex-machina/opencode-anthropic-auth@next" ];
          lsp = { };
          disabled_providers = [ "opencode" ];
        };
      };
    };
  };
}
