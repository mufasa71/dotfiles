-- We do this to load volta as nodejs manager if exists
if vim.fn.executable("volta") then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system(
    "volta which neovim-node-host"))
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
