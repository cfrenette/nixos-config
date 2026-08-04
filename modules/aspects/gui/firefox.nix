{
  den.aspects.firefox = {
    homeManager =
      { pkgs, config, ... }:
      {
        # Workaround until home-manager natively supports XDG Home override
        home.file.".mozilla/native-messaging-hosts".enable = false;

        stylix.targets.firefox.profileNames = [ "cory" ];
        programs.firefox = {
          enable = true;

          # Force new XDG standard configPath
          configPath = "${config.xdg.configHome}/mozilla/firefox";

          profiles.cory = {
            settings = {
              # Enable Video Decode support
              "media.hardware-video-decoding.force-enabled" = true;
              "signon.rememberSignons" = false;
              "identity.fxaccounts.enabled" = true;
            };
            search = {
              # Firefox tweaks this setting a lot, necessary to wipe tweaks and regenerate
              force = true;
              default = "ddg";
              engines = {
                "Nix Packages" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "type";
                          value = "packages";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "nixp:" ];
                };
                "Nix Options" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/options";
                      params = [
                        {
                          name = "type";
                          value = "options";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "nixo:" ];
                };
              };
            };
          };
        };
      };
  };
}
