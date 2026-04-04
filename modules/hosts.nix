{ den, ... }:
{
  den.ctx.host.includes = [
    den.aspects.os-defaults._.osConfig
    den.provides.hostname
  ];
  den.hosts.x86_64-linux.wsl.users.cory = { };
  den.hosts.x86_64-linux.frmwrk.users.cory = { };
}
