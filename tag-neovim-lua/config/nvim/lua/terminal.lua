local Terminal = require("toggleterm.terminal").Terminal
local YarnTest = Terminal:new({ cmd = "yarn test --watch", hidden = true })
local YarnStart = Terminal:new({ cmd = "yarn start", hidden = true })

vim.api.nvim_create_user_command('YarnStart', function() YarnStart:toggle() end, {})
vim.api.nvim_create_user_command('YarnTest', function() YarnTest:toggle() end, {})
