return require("packer").startup(function(use)
  use {"wbthomason/packer.nvim"}

  use {"tpope/vim-fugitive"}
  use {"tpope/vim-rhubarb"}
  use {"lewis6991/gitsigns.nvim"}

  use {"tpope/vim-sleuth", "tpope/vim-repeat"}

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"}, {"nvim-telescope/telescope-github.nvim"}
    }
  }
  use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}

  use {"lukas-reineke/indent-blankline.nvim"}
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use {"nvim-treesitter/nvim-treesitter-textobjects"}

  use {
    "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer",
    "simrat39/rust-tools.nvim"
  }

  use {"kosayoda/nvim-lightbulb"}

  use {"onsails/lspkind-nvim"}
  use {"sbdchd/neoformat"}
  use {"jparise/vim-graphql", "hashivim/vim-terraform"}

  use {
    "folke/which-key.nvim",
    config = function() require("which-key").setup {} end
  }
  use {"jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim"}
  use {"brooth/far.vim"}
  use {"mhartington/formatter.nvim"}
  use {"lbrayner/vim-rzip"}
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
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end
  }
  use {"jose-elias-alvarez/typescript.nvim"}
  use {"github/copilot.vim"}
  use {
    "echasnovski/mini.nvim",
    branch = "stable",
    requires = {{"JoosepAlviste/nvim-ts-context-commentstring"}},
    config = function()
      require("mini.comment").setup {
        hooks = {
          pre = function()
            require("ts_context_commentstring.internal").update_commentstring({})
          end
        }
      }
      require("mini.jump").setup {}
      require("mini.surround").setup {}
      require("mini.pairs").setup {}
      require("mini.completion").setup {
        lsp_completion = {source_func = "omnifunc", auto_setup = false}
      }
      vim.api.nvim_set_keymap("i", "<Tab>",
                              [[pumvisible() ? "\<C-n>" : "\<Tab>"]],
                              {noremap = true, expr = true})
      vim.api.nvim_set_keymap("i", "<S-Tab>",
                              [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]],
                              {noremap = true, expr = true})
    end
  }
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        terminal_mappings = false,
        open_mapping = [[<c-\>]]
      }
    end
  }

  -- Theme
  use {"EdenEast/nightfox.nvim"}
  use {"rebelot/kanagawa.nvim"}
end)
