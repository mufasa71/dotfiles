local Terminal = require("toggleterm.terminal").Terminal
local yarn_start = Terminal:new({cmd = "yarn start", hidden = true})
local yarn_test = Terminal:new({cmd = "yarn test --watch", hidden = true})

function _yarn_start_toggle() yarn_start:toggle() end
function _yarn_test_toggle() yarn_test:toggle() end

vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua _yarn_start_toggle()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _yarn_test_toggle()<CR>",
                        {noremap = true, silent = true})
