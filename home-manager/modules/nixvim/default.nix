{ lib, ... }:

with lib;

{
  imports = [
    ./autoclose.nix
    ./blink.nix
    ./conform.nix
    ./gitsigns.nix
    ./git-conflict.nix
    ./lsp.nix
    ./surround.nix
    ./telescope.nix
    ./treesitter.nix
    ./yazi.nix
  ];

  options = { };

  config = {
    programs.nixvim = {
      performance = {
        byteCompileLua.plugins = true;
      };

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
          action = "<cmd>wa<cr>";
          key = "<C-S-s>";
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
        fillchars = {
          eob = " ";
        };
        jumpoptions = "stack";
        # timeoutlen = 0;
      };
      globals.mapleader = " ";
      globals.omni_sql_no_default_maps = 1;

      plugins.yazi.enable = mkDefault true;
      plugins.lsp.enable = mkDefault true;
      plugins.conform-nvim.enable = mkDefault true;
      plugins.autoclose.enable = mkDefault true;
      plugins.gitsigns.enable = mkDefault true;
      plugins.git-conflict.enable = mkDefault true;
    };
  };
}
