{
  # enable remote build for aarch64 (pi)
  den.aspects.binfmt._.aarch64.nixos.boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
