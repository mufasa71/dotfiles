return require("packer").startup(function(use)
  use { "wbthomason/packer.nvim" }

  use { "tpope/vim-fugitive" }
  use { "tpope/vim-rhubarb" }
  use { "tpope/vim-sleuth", "tpope/vim-repeat" }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-github.nvim" }
    }
  }
  use { "lewis6991/gitsigns.nvim" }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = false
      }
    end
  }
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-treesitter/nvim-treesitter-textobjects" }
  use {
    "m-demare/hlargs.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("hlargs").setup() end
  }
  use {
    "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig", "simrat39/rust-tools.nvim",
  }
  use { "kosayoda/nvim-lightbulb" }
  use { "onsails/lspkind-nvim" }
  use { "sbdchd/neoformat" }
  use { "jparise/vim-graphql", "hashivim/vim-terraform" }
  use {
    "folke/which-key.nvim",
    config = function() require("which-key").setup {} end
  }
  use { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" }
  use { "brooth/far.vim" }
  use { "mhartington/formatter.nvim" }
  use { "lbrayner/vim-rzip" }
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function() require("trouble").setup {} end
  }
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  }
  use {
    "nvim-tree/nvim-tree.lua",
    config = function() require "nvim-tree".setup {} end,
    requires = {
      "nvim-tree/nvim-web-devicons" -- optional, for file icon
    },
    tag = 'nightly'
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end
  }
  use { "jose-elias-alvarez/typescript.nvim" }
  use { "github/copilot.vim" }
  use {
    "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline", "hrsh7th/nvim-cmp", "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip"
  }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end
  }
  use({
    "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup({}) end
  })
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        terminal_mappings = false,
        open_mapping = [[<c-\>]]
      }
    end
  }
  use {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons"
    },
    config = function() require "octo".setup() end
  }
  use { "folke/tokyonight.nvim" }
  use { "sindrets/diffview.nvim" }
end)
