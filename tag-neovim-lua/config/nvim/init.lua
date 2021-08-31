vim.o.inccommand = 'nosplit' --incremental live completion
vim.o.hlsearch = false --set highlight on search
vim.wo.number = true --make line numbers default
vim.o.hidden = true --do not save when switching buffers
vim.o.mouse = 'a' --enable mouse mode
vim.o.breakindent = true --enable break indent
vim.o.completeopt = 'menuone,noselect' -- set completeopt to have a better completion experience
vim.o.ignorecase = true --case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
vim.o.updatetime = 250 --decrease update time
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true --set colorscheme (order is important here)
vim.cmd [[set undofile]] --save undo history

-- Map leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Needs to set before loading lightline
vim.g.lightline = {
  colorscheme = 'oceanicnext',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

-- Needs to be set before nvim-peekup
vim.g.peekup_paste_before         = '<Leader>P'
vim.g.peekup_paste_after          = '<Leader>p'
-- Needs to be set before vim-sneak is loaded
vim.g['sneak#label']              = 1
vim.g['sneak#s_next']             = 1
vim.g['sneak#use_ic_scs']         = 0

-- Needs to set before loading treesitter
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Needs to set before shell formatter
vim.g.shfmt_opt = "-ci"

-- We do this to prevent the loading of the system fzf.vim plugin. This is
-- present at least on Arch/Manjaro
vim.api.nvim_command('set rtp-=/usr/share/vim/vimfiles')

-- We do this to load volta as nodejs manager if exists
if vim.fn.executable('volta') then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system("volta which neovim-node-host"))
end

require 'plugins'
require 'autocmd'
require 'git'
require 'treesitter'
require 'finder'
require 'keymappings'
require 'lsp'
require 'format'

vim.api.nvim_command('colorscheme OceanicNext')
