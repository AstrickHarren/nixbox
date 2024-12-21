{ pkgs, ... }:
{
  home.packages = [ pkgs.nixfmt-rfc-style ];
  programs.nixvim.plugins.conform-nvim.settings = {
    format_on_save = { lsp_format = "fallback"; };
    formatters_by_ft = {
      nix = [ "nixfmt" ];
    };
    notify_on_error = false;
  };
}
