{
  description = "Nixos Configuration (Flake-based)";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS Hardware Profiles
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Den / Dendritic Nix
    import-tree.url = "github:vic/import-tree";
    flake-aspects.url = "github:vic/flake-aspects";
    den.url = "github:vic/den";

    # Secure Boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
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
      system = "x86_64-linux";
      den =
        (inputs.nixpkgs.lib.evalModules {
          modules = [ (inputs.import-tree ./modules) ];
          specialArgs.inputs = inputs;
        }).config;
      inherit (den.den.hosts.x86_64-linux) frmwrk;
    in
    {
      nixosConfigurations.frmwrk = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          # System Configuration
          ./hosts/frmwrk/configuration.nix

          # Home Manager Configuration
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.cory.imports = [ ./home/cory/frmwrk.nix ];
              extraSpecialArgs = {
                inherit inputs;
                inherit system;
              };
            };
          }

          # Modules Migrated to Den
          frmwrk.mainModule
        ];
      };
    };
}
