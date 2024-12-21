{
  programs.nixvim = {
    plugins.cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        sources = [ { name = "nvim_lsp"; } ];
        mapping = {
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };
    };
    plugins.cmp-nvim-lsp = {
      enable = true;
    };
  };
}
