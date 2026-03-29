{
  den,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.ctx.user.includes = [
    # Enable host<->user config via .provides
    den._.mutual-provider
  ];

}
