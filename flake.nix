{
  description = "Nixos Configuration (Flake-based)";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS Hardware Profiles
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Secure Boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    # Temporary fix for nix-community/lanzaboote#485
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Sops (Secrets Management)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom Nixvim Flake
    nixvim = {
      url = "github:cfrenette/nvim";
    };

    # Stylix (Theme management)
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Encrypted Secrets Repo
    nix-secrets = {
      url = "git+ssh://git@github.com/cfrenette/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };

  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      # Function for NixOS configuration by host
      # (this is due for a refactor)
      mkHost =
        hostname: arch:
        nixpkgs.lib.nixosSystem {
          system = "${arch}";
          specialArgs.inputs = inputs;
          modules = [
            # System Configuration
            ./hosts/${hostname}/configuration.nix

            # Home Manager Configuration
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.cory.imports = [ ./home/cory/${hostname}.nix ];
                extraSpecialArgs = {
                  inherit inputs;
                  system = "${arch}";
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        frmwrk = mkHost "frmwrk" "x86_64-linux";
      };
    };
}
