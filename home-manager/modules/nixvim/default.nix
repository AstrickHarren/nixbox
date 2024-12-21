{
  imports = [
    ./cmp.nix
    ./telescope.nix
    ./yazi.nix
    ./conform.nix
    ./lsp.nix
    ./autoclose.nix
    ./luasnip.nix
    ./surround.nix
  ];

  options = { };

  config = {
    programs.nixvim = {
      diagnostics = {
        virtual_text = {
          severity.__raw = ''
            vim.diagnostic.severity.ERROR
          '';
        };
      };

      autoCmd = [
        {
          command = "wall";
          event = [ "BufLeave" ];
          pattern = [ "*" ];
        }
      ];

      keymaps = [
        {
          action = "<cmd>w<cr>";
          key = "<C-s>";
          options = {
            silent = true;
          };
          mode = [
            "n"
            "v"
            "i"
          ];
        }
        {
          action = "<C-r>";
          key = "U";
          options = {
            silent = true;
          };
        }
      ];
      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        swapfile = false;
        signcolumn = "yes:3";
        ph = 10;
        wrap = false;
        # timeoutlen = 0;
      };
      globals.mapleader = " ";
      globals.omni_sql_no_default_maps = 1;

      plugins.yazi.enable = true;
      plugins.lsp.enable = true;
      plugins.conform-nvim.enable = true;
      plugins.autoclose.enable = true;
    };
  };
}
