{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      checkCond = name: cond: pkgs.runCommandLocal name { } (if cond then "touch $out" else "");
      frmwrk = inputs.self.nixosConfigurations.frmwrk.config;
      wsl = inputs.self.nixosConfigurations.wsl.config;
      cory-at-frmwrk = frmwrk.home-manager.users.cory;
      cory-at-wsl = wsl.home-manager.users.cory;
    in
    {
      checks."frmwrk enables git config" = checkCond "frmwrk.provides.cory" (
        cory-at-frmwrk.programs.git.settings.user.email == "cory@frenette.dev"
      );
      checks."wsl enables git config" = checkCond "wsl.provides.cory" (
        cory-at-wsl.programs.git.settings.user.email == "coryfrenette@montrose-env.com"
      );
    };
}
