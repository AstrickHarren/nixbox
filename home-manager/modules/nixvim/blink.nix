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
            # Do not auto show menu on cmdline or search
            auto_show.__raw = ''
              function(ctx) 
                return ctx.mode ~= "cmdline" 
              end
            '';
          };
        };
        fuzzy = {
          # prebuilt_binaries.force_version = "0";
        };
        signature = {
          enabled = true;
        };
	snippets.preset = "luasnip";
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
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
