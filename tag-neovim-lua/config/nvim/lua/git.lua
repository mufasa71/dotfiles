require("gitsigns").setup {
  signs = {
    add = {hl = "GitGutterAdd", text = "+"},
    change = {hl = "GitGutterChange", text = "~"},
    delete = {hl = "GitGutterDelete", text = "_"},
    topdelete = {hl = "GitGutterDelete", text = "‾"},
    changedelete = {hl = "GitGutterChange", text = "~"}
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local wk = require "which-key"

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr = true})
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr = true})

    -- Actions
    wk.register({
      h = {
        name = "Git",
        S = {gs.stage_buffer, "Stage all hunks in current buffer"},
        s = {"<cmd>Gitsigns stage_hunk<cr>", "Stage the hunk"},
        r = {"<cmd>Gitsigns reset_hunk<cr>", "Reset the lines of the hunk"},
        R = {gs.reset_buffer, "Reset all hunks"},
        u = {gs.undo_stage_hunk, "Undo the last call of stage_hunk()"},
        p = {gs.preview_hunk, "Preview the hunk"},
        b = {function() gs.blame_line {full = true} end, "Run git blame"},
        d = {gs.diffthis, "Perform a vimdiff"},
        D = {function() gs.diffthis("~") end, "Perform vimdiff {base}"}
      },
      t = {
        b = {gs.toggle_current_line_blame, "Current line blame"},
        d = {gs.toggle_deleted, "Toggle deleted lines"}
      }
    }, {prefix = "<leader>", buffer = bufnr})

    wk.register({
      h = {
        name = "Git",
        s = {"<cmd>Gitsigns stage_hunk<cr>", "Stage the hunk"},
        r = {"<cmd>Gitsigns reset_hunk<cr>", "Reset the lines of the hunk"}
      }
    }, {prefix = "<leader>", mode = "v", buffer = bufnr})
  end
}
