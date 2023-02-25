local telescope = require "telescope"
local actions = require "telescope.actions"
local wk = require "which-key"

telescope.setup {
  pickers = {
    find_files = { theme = "dropdown" },
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      mappings = {
        i = { ["<c-d>"] = actions.delete_buffer + actions.move_to_top },
        n = { ["<c-d>"] = actions.delete_buffer + actions.move_to_top }
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

telescope.load_extension("fzf")

wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    c = {
      "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find in current buffer"
    },
    h = { "<cmd>Telescope help_tags<cr>", "Find help tags" },
    t = { "<cmd>Telescope tags<cr>", "Find tags" },
    d = { "<cmd>Telescope grep_string<cr>", "Searches for the string in cwd" },
    g = {
      "<cmd>Telescope live_grep<cr>",
      "Search for a string in cwd and get live result"
    }
  },
  g = {
    name = "git",
    s = { "<cmd>Telescope git_status<cr>", "List current changes" },
    c = { "<cmd>Telescope git_commits<cr>", "List commits" },
    p = { "<cmd>Telescope gh pull_request<cr>", "List pull requests" }
  }
}, { prefix = "<leader>" })
