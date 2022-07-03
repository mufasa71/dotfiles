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
  use {"nvim-treesitter/nvim-treesitter-textobjects"}

  use {
    "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer",
    "simrat39/rust-tools.nvim"
  }

  use {"kosayoda/nvim-lightbulb"}

  use {"onsails/lspkind-nvim"}
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      {"onsails/lspkind-nvim"}, {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-path"}
      -- {"hrsh7th/cmp-buffer"},
      -- {"hrsh7th/cmp-cmdline"},
    },
    disable = true,
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                   vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                       col, col):match("%s") == nil
      end

      cmp.setup {
        snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
        sources = {
          {name = "nvim_lsp"}, {name = "luasnip"}
          -- more sources
        },
        mappings = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {"i", "s"}),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {"i", "s"})
        }
      }
    end
  }

  ------ Snippets

  use {"L3MON4D3/LuaSnip", disable = true} -- Snippets plugin
  use {"rafamadriz/friendly-snippets", disable = true}
  use {"saadparwaiz1/cmp_luasnip", disable = true}

  ------

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
    "windwp/nvim-autopairs",
    disable = true,
    config = function()
      require("nvim-autopairs").setup {check_ts = true, ts_config = {}}
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end
  }
  use {"jose-elias-alvarez/typescript.nvim"}
  -- use {
  --   "ThePrimeagen/refactoring.nvim",
  --   requires = {{"nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter"}}
  -- }
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
    tag = "v1.*",
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
end

return packer.startup(init)
