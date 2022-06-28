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
  use "tpope/vim-rhubarb"
  use "lewis6991/gitsigns.nvim"

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
  use "nvim-treesitter/nvim-treesitter-textobjects"

  use {
    "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer",
    "simrat39/rust-tools.nvim"
  }

  use {"kosayoda/nvim-lightbulb"}

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      {"onsails/lspkind-nvim"}, {"hrsh7th/cmp-nvim-lsp"},
      -- {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"},
      {"saadparwaiz1/cmp_luasnip"}
    }
  }

  use "L3MON4D3/LuaSnip" -- Snippets plugin

  use "sbdchd/neoformat"
  use {"jparise/vim-graphql", "hashivim/vim-terraform"}

  use {
    "folke/which-key.nvim",
    config = function() require("which-key").setup {} end
  }
  use {"jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim"}
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
  use {"EdenEast/nightfox.nvim"}
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end
  }
  use "jose-elias-alvarez/typescript.nvim"
  -- use {
  --   "ThePrimeagen/refactoring.nvim",
  --   requires = {{"nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter"}}
  -- }
  use "github/copilot.vim"
  use {
    "numToStr/Comment.nvim",
    requires = {{"JoosepAlviste/nvim-ts-context-commentstring"}},
    config = function()
      require("Comment").setup {
        pre_hook = function(ctx)
          -- Only calculate commentstring for tsx filetypes
          if vim.bo.filetype == "typescriptreact" then
            local U = require("Comment.utils")

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.line and "__default" or
                             "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.block then
              location =
                  require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location =
                  require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return
                require("ts_context_commentstring.internal").calculate_commentstring(
                    {key = type, location = location})
          end
        end
      }
    end
  }
  use {
    "echasnovski/mini.nvim",
    branch = "stable",
    config = function() require("mini.surround").setup {} end
  }
end

return packer.startup(init)
