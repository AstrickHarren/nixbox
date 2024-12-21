{
  programs.nixvim.plugins.conform-nvim = {
    settings = {
      format_on_save = { };
      formatters_by_ft = {
        nix = [ "nixfmt" ];
      };
      notify_on_error = false;
    };
  };
}
