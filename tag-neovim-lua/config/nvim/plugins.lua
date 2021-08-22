-- Add the in built Cfilter plugin. Replaces QFGrep.
vim.cmd 'packadd cfilter'
vim.cmd 'packadd packer.nvim'

local init = function ()
  use {'wbthomason/packer.nvim', opt = true}
  -- Vertical Motion
  use 'justinmk/vim-sneak'
  -- Search
  use {
    'junegunn/fzf',
    run = './install --bin'
  }
  use 'junegunn/fzf.vim'
  use 'wincent/ferret'
  use 'bronson/vim-visual-star-search'
  -- Remove extraneous whitespace when edit mode is exited
  use 'ntpeters/vim-better-whitespace'
  -- Manage Project sessions
  use 'thaerkh/vim-workspace'
  -- For autocompletion
  use 'hrsh7th/nvim-compe'
  -- Git support
  use 'mhinz/vim-signify'
  use 'tpope/vim-fugitive'
  use 'rhysd/git-messenger.vim'
  use 'whiteinge/diffconflicts'
  use 'sindrets/diffview.nvim'
  -- Boost vim command line mode
  use 'vim-utils/vim-husk'
  -- Formatting
  use {
    'sbdchd/neoformat',
    cmd = 'Neoformat'
  }
  -- Run things async
  use 'hauleth/asyncdo.vim'
  -- Quickfix
  use 'yssl/QFEnter'
  use 'ronakg/quickr-cscope.vim'
  use 'milkypostman/vim-togglelist'
  use 'chengzeyi/fzf-preview.vim'
  -- Text Object plugins
  use {
    'wellle/targets.vim',
    'tpope/vim-surround',
    'tommcdo/vim-exchange',
    'chaoren/vim-wordmotion',
    'kana/vim-textobj-user',
    'kana/vim-textobj-indent',
    'kana/vim-textobj-entire',
    'glts/vim-textobj-indblock',
    'idbrii/textobj-word-column.vim',
    'danidiaz/vim-textobj-do-block'
  }
  -- Tim pope essentials
  use {
    'tpope/vim-commentary',
    'tpope/vim-repeat',
    'tpope/vim-sleuth'
  }
  -- Directory viewer
  use 'justinmk/vim-dirvish'
  -- Show leader key bindings
  use 'liuchengxu/vim-which-key'
  -- Toggle terminal
  use 'voldikss/vim-floaterm'
  -- Take care of sudo
  use 'lambdalisue/suda.vim'
  -- Alignment
  use 'junegunn/vim-easy-align'
  use 'nvim-lua/plenary.nvim'
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'jose-elias-alvarez/null-ls.nvim' }
  }
  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'ray-x/lsp_signature.nvim',
    'kosayoda/nvim-lightbulb',
  }
  -- Language support & syntax highlighting
  -- Coq
  use {
    'whonore/Coqtail',
    'jlapolla/vim-coq-plugin'
  }
  -- treesitter based syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = "require('treesitter')",
  }
  use 'nvim-treesitter/playground'
  -- All writing needs
  use 'lervag/vimtex'
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  -- Dhall
  use 'vmchale/dhall-vim'
  -- Other syntax highlighting support
  use 'inkarkat/SyntaxAttr.vim'
  -- For statusline
  use {
    'glepnir/galaxyline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  -- Marks and registers
  use {
    'kshenoy/vim-signature',
    'gennaro-tedesco/nvim-peekup'
  }
  -- Snippets
  use {
    'rafamadriz/friendly-snippets',
    'hrsh7th/vim-vsnip'
  }
  -- GDB support
  use 'sakhnik/nvim-gdb'
  -- For files with ANSI escape sequences
  use 'powerman/vim-plugin-AnsiEsc'
end

return require('packer').startup(init)
