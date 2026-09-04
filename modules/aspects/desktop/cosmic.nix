{ den, inputs, ... }:
{
  # nixpkgs PR #556651 (COSMIC stable 1.7.0) -- TEMPORARY, remove when merged.
  # Tracks the PR branch: `nix flake update nixpkgs-cosmic-pr` to pull new commits.
  flake-file.inputs.nixpkgs-cosmic-pr = {
    url = "github:thefossguy/nixpkgs/cosmic-stable-1.7.0";
    flake = false;
  };

  den.aspects.cosmic = {
    nixos = {
      services.desktopManager.cosmic.enable = true;
      services.displayManager.cosmic-greeter.enable = true;
    };

    # nixpkgs PR #556651 -- TEMPORARY variant, delete when merged.
    _.pr556651 = {
      includes = [ den.aspects.cosmic ];
      nixos.nixpkgs.overlays = [
        # nixpkgs PR #556651: call the PR's package.nix files with our own pkgs,
        # so COSMIC links against this system's mesa/wayland/stdenv.
        (
          final: _prev:
          let
            names = [
              "cosmic-app-library"
              "cosmic-applets"
              "cosmic-bg"
              "cosmic-comp"
              "cosmic-edit"
              "cosmic-files"
              "cosmic-greeter"
              "cosmic-icons"
              "cosmic-idle"
              "cosmic-initial-setup"
              "cosmic-launcher"
              "cosmic-monitor"
              "cosmic-notifications"
              "cosmic-osd"
              "cosmic-panel"
              "cosmic-player"
              "cosmic-randr"
              "cosmic-reader"
              "cosmic-screenshot"
              "cosmic-session"
              "cosmic-settings"
              "cosmic-settings-daemon"
              "cosmic-sound-theme"
              "cosmic-store"
              "cosmic-term"
              "cosmic-wallpapers"
              "cosmic-workspaces-epoch"
              "xdg-desktop-portal-cosmic"
            ];
          in
          builtins.listToAttrs (
            map (name: {
              inherit name;
              value =
                final.callPackage
                  "${inputs.nixpkgs-cosmic-pr}/pkgs/by-name/${builtins.substring 0 2 name}/${name}/package.nix"
                  { };
            }) names
          )
        )
      ];
    };
  };
}
