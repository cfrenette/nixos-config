{
  inputs,
  den,
  lib,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

  den.ctx.user.classes = lib.mkDefault [ "homeManager" ];

  den.hosts.x86_64-linux.frmwrk.users.cory = { };

  den.aspects.frmwrk = {
    includes = [ den.provides.hostname ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ ];
      };
  };

}
