"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neomake_scss_stylelint_d_maker = {
 	  \ 'args': ['-f', 'compact', '--fix'],
      \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
      \ '%W%f: line %l\, col %c\, Warning - %m'
      \}
let g:neomake_javascript_enabled_makers = ['eslint_d']

let g:neomake_scss_stylelint_d_maker = {
      \ 'errorformat':
      \   '%+P%f,'. 
      \   '%*\s%l:%c  %t  %m,'.
      \ '%-Q'
      \}
let g:neomake_scss_enabled_makers = ['stylelint_d']
autocmd! BufWritePost * Neomake
autocmd! FileChangedShellPost * Neomake

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MRU
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
let MRU_Add_Menu = 0
map <silent> <C-F> :MRU<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EasyMotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map <leader><leader>h <Plug>(easymotion-linebackward)
nmap s <Plug>(easymotion-s2)
" 2-chars search motion
nmap t <Plug>(easymotion-t2)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-racer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
let g:racer_cmd = '~/.cargo/bin/racer'
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => emmet-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
packadd webapi-vim
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.snippets.json')), "\n"))

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-jsx
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0
