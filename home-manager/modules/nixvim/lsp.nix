{
  config = {
    programs.nixvim = {
      # only show the highest severity in sign
      extraConfigLua = ''
        local ns = vim.api.nvim_create_namespace "my_namespace"
        local orig_signs_handler = vim.diagnostic.handlers.signs

        vim.diagnostic.handlers.signs = {
          show = function(_, bufnr, _, opts)
            local diagnostics = vim.diagnostic.get(bufnr)

            -- Find the "worst" diagnostic per line
            local max_severity_per_line = {}
            for _, d in pairs(diagnostics) do
              local m = max_severity_per_line[d.lnum]
              if not m or d.severity < m.severity then
                max_severity_per_line[d.lnum] = d
              end
            end

            local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
            orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
          end,
          hide = function(_, bufnr)
            orig_signs_handler.hide(ns, bufnr)
          end,
        }
      '';
      diagnostics = {
        severity_sort = true;
        signs = {
          text.__raw = ''
                      {
            	      [vim.diagnostic.severity.ERROR] = "";
            	      [vim.diagnostic.severity.WARN] = "";
            	      [vim.diagnostic.severity.INFO] = "";
            	      [vim.diagnostic.severity.HINT] = "";
                      }
          '';
          numhl.__raw = ''
                      {
            	      [vim.diagnostic.severity.ERROR] = "DiagnosticError";
            	      [vim.diagnostic.severity.WARN] = "DiagnosticWarn";
            	      [vim.diagnostic.severity.INFO] = "DiagnosticInfo";
            	      [vim.diagnostic.severity.HINT] = "DiagnosticHint";
                      }
          '';
        };
      };

      plugins.lsp.servers = {
        nixd.enable = true;
      };

      plugins.lsp.keymaps = {
        lspBuf = {
          gd = "definition";
          gD = "references";
          gi = "implementation";
          gt = "type_definition";
          "R" = "rename";
          "<C-.>" = "code_action";
          "<C-,>" = "signature_help";
        };

        diagnostic = {
          "]d" = "goto_next";
          "[d" = "goto_prev";
        };

        extra = [
          {
            action.__raw = "vim.lsp.buf.signature_help";
            mode = "i";
            key = "<C-,>";
          }
          {
            action.__raw = "vim.lsp.buf.code_action";
            mode = [
              "v"
              "i"
            ];
            key = "<C-.>";
          }
        ];
      };

      keymaps = [
        {
          action.__raw = "vim.diagnostic.open_float";
          key = "Y";
          options = {
            silent = true;
          };
        }
      ];
    };
  };
}
