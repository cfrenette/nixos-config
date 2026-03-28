{
  den.aspects.azure-cli = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          (azure-cli.withExtensions [ azure-cli.extensions.azure-devops ])
        ];
      };
  };
}
