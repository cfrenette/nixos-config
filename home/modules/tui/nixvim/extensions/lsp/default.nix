{ ... }:
{

  plugins.lsp.servers = {
    rust_analyzer = {
      enable = true;
      # Use the more up-to-date versions in a devshell
      installRustc = false;
      installCargo = false;
    };
  };

}
