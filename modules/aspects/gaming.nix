{
  den.aspects.gaming = {
    nixos =
      { pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          extraCompatPackages = [ pkgs.proton-ge-bin ];
        };
        programs.gamemode.enable = true;

        # Proton 10+ prefers ntsync over esync/fsync when /dev/ntsync exists.
        boot.kernelModules = [ "ntsync" ];

        environment.systemPackages = with pkgs; [
          r2modman
        ];
      };
  };
}
