{ den, ... }:
{
  # Default Home Manager Settings
  den.schema.hm-host.includes = [ den.aspects.hm-defaults._.osConfig ];
  den.schema.user.includes = [ den.aspects.hm-defaults._.hmConfig ];
}
