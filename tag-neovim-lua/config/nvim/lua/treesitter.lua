-- Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  highlight = {enable = true, additional_vim_regex_highlighting = false},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
  },
  indent = {enable = true},
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["aC"] = "@call.outer",
        ["iC"] = "@call.inner",
        ["ao"] = "@class.outer",
        ["io"] = "@class.inner",
        ["at"] = "@comment.outer",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
        ["is"] = "@scopename.inner",
        ["as"] = "@statement.outer"
      }
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"},
      goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer"
      },
      goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}
    }
  }
}
