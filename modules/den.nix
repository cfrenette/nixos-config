{ inputs, lib, ... }:
{
  imports = [ inputs.den.flakeModule ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # Remove after 2027-01-01, when it becomes den's default.
  den.migrations.user-host-content.acknowledged = true;
}
