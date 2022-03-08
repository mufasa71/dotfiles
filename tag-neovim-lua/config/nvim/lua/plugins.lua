-- Add the in built Cfilter plugin. Replaces QFGrep.
vim.cmd "packadd cfilter"
vim.cmd "packadd packer.nvim"

-- Install packer if needed
local install_path = vim.fn.stdpath "data" ..
                         "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                     install_path)
end

local packer = require("packer")
local use = packer.use

packer.init {git = {clone_timeout = 60}}

local init = function()
  use "wbthomason/packer.nvim"

  use "tpope/vim-fugitive"
  use "lewis6991/gitsigns.nvim"

  use {"tpope/vim-surround", "tommcdo/vim-exchange"}

  use {"tpope/vim-commentary", "tpope/vim-sleuth", "tpope/vim-repeat"}

  use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/plenary.nvim"}}}
  use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}

  use {"lukas-reineke/indent-blankline.nvim"}
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

  use {
    "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer",
    "simrat39/rust-tools.nvim"
  }

  use {"kosayoda/nvim-lightbulb"}

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      {"onsails/lspkind-nvim"}, {"hrsh7th/cmp-vsnip"}, {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"},
      {"hrsh7th/cmp-nvim-lsp-signature-help"},
      {"hrsh7th/vim-vsnip", "hrsh7th/vim-vsnip-integ"}
    }
  }

  use "sbdchd/neoformat"
  use {"jparise/vim-graphql", "hashivim/vim-terraform"}

  use {
    "folke/which-key.nvim",
    config = function() require("which-key").setup {} end
  }
  use {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    requires = {"jose-elias-alvarez/null-ls.nvim"}
  }
  use "brooth/far.vim"
  use "mhartington/formatter.nvim"
  use "lbrayner/vim-rzip"
  use "rebelot/kanagawa.nvim"
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup {} end
  }
  use {
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true}
  }
  use {
    "kyazdani42/nvim-tree.lua",
    config = function() require"nvim-tree".setup {} end,
    requires = {
      "kyazdani42/nvim-web-devicons" -- optional, for file icon
    }
  }
  use "rafamadriz/friendly-snippets"
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {check_ts = true, ts_config = {}}
    end
  }
end

return packer.startup(init)
