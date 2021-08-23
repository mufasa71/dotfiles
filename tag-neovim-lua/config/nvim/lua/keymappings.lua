local remap = vim.api.nvim_set_keymap

--Remap comma as leader key
remap('', '<Space>', '<Nop>', { noremap = true, silent = true })

--Remap for dealing with word wrap
remap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
remap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
-- Y yank until the end of line
remap('n', 'Y', 'y$', { noremap = true })

-- Save
remap('n', '<Leader>w', '<Esc>:w<CR>', { noremap = true })

-- Search and Replace
remap('n', '<Leader>c.', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>', { noremap = true })

-- Quit
remap('n', '<Leader>x', '<Esc>:x<CR>',  { noremap = true })
remap('n', '<Leader>q', '<Esc>:q<CR>',  { noremap = true })
remap('n', '<Leader>Q', '<Esc>:qa<CR>', { noremap = true })
-- Navigate buffers
remap('n', '[b', ':bprevious<CR>', { noremap = true })
remap('n', ']b', ':bnext<CR>',     { noremap = true })
remap('n', '[B', ':bfirst<CR>',    { noremap = true })
remap('n', ']B', ':blast<CR>',     { noremap = true })
