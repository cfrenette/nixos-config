{
  den.aspects.opencode = {
    homeManager = {
      programs.opencode = {
        enable = true;
        settings = {
          "$schema" = "https://opencode.ai/config.json";
          plugin = [ "@ex-machina/opencode-anthropic-auth" ];
          lsp = { };
          disabled_providers = [ "opencode" ];
        };
      };
    };
  };
}
