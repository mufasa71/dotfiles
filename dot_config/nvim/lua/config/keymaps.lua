-- Keymaps are automatically loaded on the VeryLazy event

local map = vim.keymap
local opts = { noremap = true, silent = true }

map.set("n", "[b", "<cmd>bprevious<cr>", opts)
map.set("n", "]b", "<cmd>bnext<cr>", opts)
