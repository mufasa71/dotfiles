-- Enable the experimental new loader.
vim.loader.enable()
-- Load the plugins
require("config.lazy").setup()

vim.cmd [[colorscheme tokyonight-moon]]
