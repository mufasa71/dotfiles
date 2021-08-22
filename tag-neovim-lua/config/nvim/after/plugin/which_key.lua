local remap = vim.api.nvim_set_keymap

vim.g.which_key_use_floating_win = 1

remap('n', '<Leader>', ':<C-U>WhichKey \'<Space>\'<CR>', { noremap = true, silent = true })
remap('n', '<LocalLeader>', ':<C-U>WhichKey \',\'<CR>',  { noremap = true, silent = true })
