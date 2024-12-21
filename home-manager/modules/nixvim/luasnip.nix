{
  programs.nixvim = {
    plugins.luasnip.enable = true;

    plugins.cmp.settings = {
      snippet = {
        expand = "function(args)
		      require'luasnip'.lsp_expand(args.body)
		    end";
      };
    };

    keymaps = [
      {
        key = "<C-l>";
        mode = [
          "i"
          "s"
        ];
        action.__raw = "function() require('luasnip').jump(1) end";
      }
      {
        key = "<C-h>";
        mode = [
          "i"
          "s"
        ];
        action.__raw = "function() require('luasnip').jump(-1) end";
      }
    ];
  };
}
