{
  description = "Nixos Configuration (Flake-based)";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/cda48547b432e8d3b18b4180ba07473762ec8558";

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

    # Nixvim
    nixvim = {
      url = "github:cfrenette/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
    inputs:
    (inputs.nixpkgs.lib.evalModules {
      modules = [ (inputs.import-tree ./modules) ];
      specialArgs.inputs = inputs;
    }).config.flake;
}
