{
  description = "Nixos Configuration (Flake-based)";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # NixOS Hardware Profiles
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Secure Boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Sops (Secrets Management)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # COSMIC Flake
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs-stable";
    };

    # Nixvim (Neovim configured with nix)
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix (Theme management)
    stylix = {
      url = "github:danth/stylix/release-24.05";
    };

    # Encrypted Secrets Repo
    nix-secrets = {
      url = "git+ssh://git@github.com/cfrenette/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };

  };

  outputs = { nixpkgs, home-manager, ... } @inputs:
    let
      # Function for NixOS configuration by host
      mkHost = hostname: arch:
        nixpkgs.lib.nixosSystem {
          system = "${arch}";
          specialArgs.inputs = inputs;
          modules =
            [
              # Cosmic
              {
                nix.settings = {
                  substituters = [ "https://cosmic.cachix.org/" ];
                  trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                };
              }
              inputs.nixos-cosmic.nixosModules.default

              # System Configuration
              ./hosts/${hostname}/configuration.nix

              # Home Manager Configuration
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.cory.imports = [ ./home/cory/${hostname}.nix ];
                  extraSpecialArgs.inputs = inputs;
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
