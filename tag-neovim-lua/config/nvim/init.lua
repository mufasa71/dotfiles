vim.o.inccommand = "nosplit" -- incremental live completion
vim.o.hlsearch = false -- set highlight on search
vim.wo.number = true -- make line numbers default
vim.o.hidden = true -- do not save when switching buffers
vim.o.mouse = "a" -- enable mouse mode
vim.o.breakindent = true -- enable break indent
-- vim.o.completeopt = "menuone,noselect" -- set completeopt to have a better completion experience
vim.o.ignorecase = true -- case insensitive searching UNLESS /C or capital in search
vim.o.mousescroll = "ver:5,hor:2" -- mouse scroll speed
vim.o.smartcase = true
vim.o.updatetime = 250 -- decrease update time
vim.wo.signcolumn = "yes"
vim.o.termguicolors = true -- set colorscheme (order is important here)
vim.cmd [[set undofile]] -- save undo history

-- Map leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Needs to set before loading treesitter
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = {"help", "packer"}
vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
vim.g.indent_blankline_char_highlight = "LineNr"
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Needs to set before shell formatter
vim.g.shfmt_opt = "-ci"

-- We do this to prevent the loading of the system fzf.vim plugin. This is
-- present at least on Arch/Manjaro
vim.api.nvim_command("set rtp-=/usr/share/vim/vimfiles")

-- We do this to load volta as nodejs manager if exists
if vim.fn.executable("volta") then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system(
                                         "volta which neovim-node-host"))
end

require "plugins"
require "autocmd"
require "git"
require "treesitter"
require "finder"
require "keymappings"
require "lsp"
require "format"
require "terminal"

-- vim.api.nvim_command("colorscheme kanagawa")
vim.api.nvim_command("colorscheme nordfox")

-- require("luasnip.loaders.from_vscode").lazy_load()

local keys = {
  ["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
  ["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
  ["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true)
}
_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    -- If popup is visible, confirm selected item or add new line otherwise
    local item_selected = vim.fn.complete_info()["selected"] ~= -1
    return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
  else
    -- If popup is not visible, use plain `<CR>`. You might want to customize
    -- according to other plugins. For example, to use 'mini.pairs', replace
    -- next line with `return require('mini.pairs').cr()`
    -- return keys["cr"]
    return require("mini.pairs").cr()
  end
end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua._G.cr_action()",
                        {noremap = true, expr = true})
