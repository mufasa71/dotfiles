"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neomake_javascript_eslint_d_maker = {
 	  \ 'args': ['-f', 'compact', '--fix'],
      \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
      \ '%W%f: line %l\, col %c\, Warning - %m'
      \}
let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_jsx_enabled_makers = ['eslint_d']

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
" move to line
map <leader>L <Plug>(easymotion-bd-jk)
nmap <leader>L <Plug>(easymotion-overwin-line)
" move to word
map  <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map <leader><leader>h <Plug>(easymotion-linebackward)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
nmap t <Plug>(easymotion-t2)
" <leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)

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
