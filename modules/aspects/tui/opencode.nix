{
  den.aspects.opencode = {
    homeManager = {
      programs.opencode = {
        enable = true;
        settings = {
          "$schema" = "https://opencode.ai/config.json";
          provider = {
            ollama = {
              npm = "@ai-sdk/openai-compatible";
              name = "Ollama";
              options = {
                "baseURL" = "http://localhost:11434/v1";
              };
              models = {
                "gemma4:31b" = {
                  name = "Gemma 4 31B";
                };
              };
            };
          };
          model = "ollama/gemma4:e4b";
          disabled_providers = [ "opencode" ];
        };
      };
    };
  };
}
