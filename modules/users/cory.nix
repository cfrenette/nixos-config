{ den, ... }:

{
  den.aspects.cory = {
    includes = [
      den.provides.primary-user
      (den.provides.user-shell "bash")
      # Hosts with a display add den.aspects.tui on top.
      den.aspects.headless
    ];
    nixos = {
      users.users.cory.description = "Cory Frenette";
      users.users.cory.openssh.authorizedKeys.keyFiles = [ ../id_ed25519.pub ];
    };
  };
}
