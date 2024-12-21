{ lib, ... }:
with lib;
{
  programs.ripgrep.enable = true;
  programs.nixvim.plugins.telescope = {
    enable = mkDefault true;
    extensions = {
      ui-select = {
        enable = mkDefault true;
        settings.__raw = ''
          {
            require("telescope.themes").get_cursor { }
          }'';
      };
      fzf-native.enable = mkDefault true;
    };
    keymaps = {
      "<C-p>" = {
        action = "diagnostics sort_by=severity";
      };
      "<C-f>" = {
        action = "find_files";
      };
      "<C-S-f>" = {
        action = "find_files hidden=true";
      };
      "<C-g>" = {
        action = "live_grep";
      };
      "<C-t>" = {
        action = "lsp_dynamic_workspace_symbols";
      };
      "<C-r>" = {
        action = "resume";
      };
    };
    settings.defaults = {
      mappings = {
        i = {
          "<C-j>" = "move_selection_next";
          "<C-k>" = "move_selection_previous";
          "<C-Cr>" = "select_vertical";
        };
      };
    };
    settings.pickers = {
      lsp_dynamic_workspace_symbols = {
        sorter.__raw = ''
          require('telescope').extensions.fzf.native_fzf_sorter ({
            fuzzy = true; 
            override_generic_sorter = true; 
            override_file_sorter = true;
            case_mode = "smart_case"
          });
        '';
      };
    };
  };
}
