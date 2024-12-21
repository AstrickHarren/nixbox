let
  defKey =
    {
      key,
      gitsignFn,
      mode ? [ "n" ],
    }@input:
    let
      body = gitsignFn "require('gitsigns')";
    in
    {
      inherit key mode;
      action.__raw = "function() ${body} end";
      options = {
        silent = true;
      };
    };
in
{
  programs.nixvim.keymaps = map defKey [
    {
      key = "ghs";
      gitsignFn = m: "${m}.stage_hunk()";
    }
    {
      key = "ghu";
      gitsignFn = m: "${m}.undo_stage_hunk()";
    }
    {
      key = "ghr";
      gitsignFn = m: "${m}.reset_hunk()";
    }
    {
      key = "ghs";
      gitsignFn = m: "${m}.stage_hunk {vim.fn.line('.'), vim.fn.line('v')}";
      mode = [ "v" ];
    }
    {
      key = "ghr";
      gitsignFn = m: "${m}.reset_hunk {vim.fn.line('.'), vim.fn.line('v')}";
      mode = [ "v" ];
    }
    {
      key = "ghp";
      gitsignFn = m: "${m}.preview_hunk_inline()";
    }
    {
      key = "ghb";
      gitsignFn = m: "${m}.blame_line{full=true}";
    }
    {
      key = "gb";
      gitsignFn = m: "${m}.toggle_current_line_blame()";
    }
    {
      key = "ah";
      gitsignFn = m: "${m}.select_hunk()";
      mode = [
        "o"
        "x"
      ];
    }
    {
      key = "ih";
      gitsignFn = m: "${m}.select_hunk()";
      mode = [
        "o"
        "x"
      ];
    }
  ];
}
