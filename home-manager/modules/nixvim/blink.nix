{
  programs.nixvim = {
    plugins.lsp.capabilities = ''
      capabilities = require('blink.cmp').get_lsp_capabilities()
    '';

    plugins.luasnip.enable = true;

    plugins.blink-cmp = {
      enable = true;
      settings = {
        appearance = {
          use_nvim_cmp_as_default = true;
        };
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
              force_allow_filetypes = [ "rust" ];
            };
          };
          menu = {
            draw.treesitter = [ "lsp" ];
          };
        };
        signature = {
          enabled = true;
        };
        snippets = {
          expand.__raw = "function(snippet) require('luasnip').lsp_expand(snippet) end";
          active.__raw = ''
            function(filter)
                  if filter and filter.direction then
            	return require('luasnip').jumpable(filter.direction)
                  end
                  return require('luasnip').in_snippet()
                end
          '';
          jump.__raw = "function(direction) require('luasnip').jump(direction) end";
        };
        sources = {
          default = [
            "lsp"
            "path"
            "luasnip"
            "buffer"
          ];
        };
        keymap = {
          "<C-j>" = [
            "select_next"
            "fallback"
          ];
          "<C-k>" = [
            "select_prev"
            "fallback"
          ];
          "<C-u>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-d>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<C-l>" = [
            "snippet_forward"
            "fallback"
          ];
          "<C-h>" = [
            "snippet_backward"
            "fallback"
          ];
          "<C-Space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<CR>" = [
            "accept"
            "fallback"
          ];
        };
      };
    };
  };
}
