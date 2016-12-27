set noexpandtab

let g:neomake_javascript_enabled_makers = ['eslint_d']

autocmd! BufWritePost * Neomake
