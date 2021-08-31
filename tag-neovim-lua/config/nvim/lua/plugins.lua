-- Add the in built Cfilter plugin. Replaces QFGrep.
vim.cmd 'packadd cfilter'
vim.cmd 'packadd packer.nvim'

-- Install packer if needed
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require('packer')
local use = packer.use

packer.init {
  git = {
    clone_timeout = 60
  }
}

local init = function ()
  use 'wbthomason/packer.nvim'

  -- Git support
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim' -- add git related info in the signs columns and popups
  -- use { 'tanvirtin/vgit.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Text Object plugins
  use {
    'tpope/vim-surround',
    'tommcdo/vim-exchange',
    'justinmk/vim-sneak'
  }

  -- Tim pope essentials
  use {
    'tpope/vim-commentary', -- "gc" to comment visual regions/lines
    'tpope/vim-sleuth',
    'tpope/vim-repeat'
  }

  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- use { 'kyazdani42/nvim-web-devicons' }

  -- use 'itchyny/lightline.vim' -- Fancier statusline
    -- For statusline
  use {
    'glepnir/galaxyline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Treesitter based syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = "require('treesitter')",
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
    'kabouzeid/nvim-lspinstall',
    'kosayoda/nvim-lightbulb'
  }

  use 'hrsh7th/nvim-compe' -- Autocompletion plugin

  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Formatting
  use 'sbdchd/neoformat'

  use 'mhartington/oceanic-next'
  -- File spcecific support
  use {
    'jparise/vim-graphql',
    'hashivim/vim-terraform'
  }

  use 'liuchengxu/vim-which-key'
  use 'lambdalisue/suda.vim'

  use 'nvim-lua/plenary.nvim'
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'jose-elias-alvarez/null-ls.nvim' }
  }
  use 'brooth/far.vim'
  use 'phaazon/hop.nvim'
  use 'mhartington/formatter.nvim'
end

return packer.startup(init)
