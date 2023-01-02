local Terminal = require("toggleterm.terminal").Terminal
local YarnTest = Terminal:new({ cmd = "yarn test --watch", hidden = true })
local YarnStart = Terminal:new({ cmd = "yarn start", hidden = true })
local YarnInstall = Terminal:new({ cmd = "yarn install", hidden = true })
local GithubRepoSync = Terminal:new({ cmd = "gh repo sync", hidden = true })
local GithubCleanBranches = Terminal:new({ cmd = "gh clean-branches --force", hidden = true })

vim.api.nvim_create_user_command('YarnStart', function() YarnStart:toggle() end, {})
vim.api.nvim_create_user_command('YarnTest', function() YarnTest:toggle() end, {})
vim.api.nvim_create_user_command('YarnInstall', function() YarnInstall:toggle() end, {})
vim.api.nvim_create_user_command('GithubRepoSync', function() GithubRepoSync:toggle() end, {})
vim.api.nvim_create_user_command('GithubCleanBranches', function() GithubCleanBranches:toggle() end, {})
