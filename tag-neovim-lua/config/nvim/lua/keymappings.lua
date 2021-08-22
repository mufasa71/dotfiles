local remap = vim.api.nvim_set_keymap

--Remap space as leader key
remap('', '<Space>', '<Nop>', { noremap = true, silent = true })

--Remap for dealing with word wrap
remap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
remap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
-- Y yank until the end of line
remap('n', 'Y', 'y$', { noremap = true })


