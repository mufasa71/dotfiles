local wk = require "which-key"
local remap = vim.keymap.set

remap("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
remap("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
remap("n", "Y", "y$", {noremap = true, silent = true})

wk.register({
  name = "General",
  -- w = {"<esc>:w<cr>", "Write current buffer"}, -- conflicts with workspace
  ["c."] = {":%s/\\<<C-r><C-w>\\>//g<Left><Left>", "Search and replace"},
  -- x = {"<esc>:x<cr>", "Write if changes and quite"},
  q = {"<esc>:q<cr>", "Quit current buffer"},
  Q = {"<esc>:q<cr>", "Quit all buffers"},

  ["[b"] = {"<cmd>:bprevious<cr>", "Previous buffer"},
  ["]b"] = {"<cmd>:bnext<cr>", "Next buffer"},
  ["[B"] = {"<cmd>:bfirst<cr>", "First buffer"},
  ["]B"] = {"<cmd>:blast<cr>", "Last buffer"},

  x = {
    name = "Trouble",
    x = {"<cmd>Trouble<cr>", "Open the list"},
    w = {"<cmd>Trouble workspace_diagnostics<cr>", "Open workspace"},
    d = {"<cmd>Trouble document_diagnostics<cr>", "Open diagnostics"},
    l = {"<cmd>Trouble loclist<cr>", "Open location list"},
    q = {"<cmd>Trouble quickfix<cr>", "Open quickfix list"},
    R = {"<cmd>Trouble lsp_references<cr>", "Open quickfix list"}
  },

  r = {"<cmd>NvimTreeRefresh<cr>", "Tree refresh"},
  n = {"<cmd>NvimTreeFindFile<cr>", "Find file in tree"}
}, {prefix = "<leader>"})

wk.register({["<C-n>"] = {"<cmd>NvimTreeToggle<cr>", "Open tree"}});

remap("i", "<C-J>", "copilot#Accept(\"<CR>\")",
      {expr = true, silent = true})
vim.g.copilot_no_tab_map = true

-- Remap comma as leader key
-- vim.keymap.set("", "<Space>", "<Nop>", {noremap = true, silent = true})
