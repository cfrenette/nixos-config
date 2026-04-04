{ den, ... }:
{
  # Default Home Manager Settings
  den.ctx.hm-host.includes = [ den.aspects.hm-defaults._.osConfig ];
  den.ctx.hm-user.includes = [ den.aspects.hm-defaults._.hmConfig ];
}
