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

  # FIXME: Stylix's target still writes the OpenCode 1 tui.json; OpenCode 2 reads cli.json
  # Override until upstream updates.
  den.aspects.stylix.nixos.home-manager.sharedModules = [
    (
      { config, lib, ... }:
      lib.mkIf config.stylix.targets.opencode.enable {
        programs.opencode = {
          tui = lib.mkForce { };
          cli.theme.name = "stylix";
        };
      }
    )
  ];
}
