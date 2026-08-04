{
  den,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.schema.user.includes = [
    # Enable host<->user config via .provides
    den._.mutual-provider
  ];

}
