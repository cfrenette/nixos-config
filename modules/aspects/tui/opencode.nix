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
                "hf.co/rico03/Qwen3.6-27B-Claude-Opus-Reasoning-Distilled-GGUF:Q4_K_M" = {
                  name = "rico03/Qwen3.6-27B-Claude-Distill";
                };
              };
            };
          };
          model = "ollama/rico03/Qwen3.6-27B-Claude-Distill";
          disabled_providers = [ "opencode" ];
        };
      };
    };
  };
}
