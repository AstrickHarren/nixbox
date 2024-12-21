{ lib, config, ... }:
{
  options = {
    programs.nixvim.diagnostic.manual_sign_filter = lib.mkEnableOption "manually filter all signs per line by their most serverities";
  };
  config = {
    programs.nixvim = {
      # only show the highest severity in sign
      # workaround for rust analzyer cancel
      extraConfigLua = lib.mkIf config.programs.nixvim.diagnostic.manual_sign_filter ''
        local ns = vim.api.nvim_create_namespace "my_namespace"
        local orig_signs_handler = vim.diagnostic.handlers.signs


        for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
            local default_diagnostic_handler = vim.lsp.handlers[method]
            vim.lsp.handlers[method] = function(err, result, context, config)
        	if err ~= nil and err.code == -32802 then
        	    return
        	end
        	return default_diagnostic_handler(err, result, context, config)
            end
        end

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
          action.__raw = "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end";
          key = "<M-k>";
          options = {
            silent = true;
          };
        }
        {
          action.__raw = "vim.diagnostic.open_float";
          key = "Y";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>LspRestart<cr>";
          key = "<M-l>";
          options = {
            silent = true;
          };
        }
      ];
    };
  };
}
