local escape = vim.fn.fnameescape
local buf_name = vim.api.nvim_buf_get_name

require('formatter').setup({
  filetype = {
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", escape(buf_name(0)), ''},
          stdin = true
        }
      end
    },
    typescript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", escape(buf_name(0)), ''},
          stdin = true
        }
      end
    },
  }
})

local remap = vim.api.nvim_set_keymap

remap('n', '<Leader>F', "<cmd>Format<cr>", { noremap = true, silent = true })
