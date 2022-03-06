local wk = require "which-key"
local escape = vim.fn.fnameescape
local buf_name = vim.api.nvim_buf_get_name

local prettier = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", escape(buf_name(0)), ""},
    stdin = true
  }
end

local lua = function()
  return {
    exe = "lua-format",
    args = {
      "--tab-width", 2, "--indent-width", 2, "--single-quote-to-double-quote"
    },
    stdin = true
  }
end

require("formatter").setup({
  filetype = {
    javascript = {prettier},
    typescript = {prettier},
    typescriptreact = {prettier},
    lua = {lua}
  }
})

local remap = vim.api.nvim_set_keymap

remap("n", "<Leader>F", "<cmd>Format<cr>", {noremap = true, silent = true})
