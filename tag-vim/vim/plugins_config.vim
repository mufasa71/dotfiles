"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = '\v[\/](vendor|node_modules)$'
let g:ctrlp_reuse_window = 'startify'
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_max_depth = 40

if has('unix')
  " use the silver searcher https://github.com/ggreer/the_silver_searcher
  if executable('ag')
    " use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " use ag in ctrlp for listing files
    " also a lot faster in git projects with respects .gitignore
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'ag %s -l --nocolor -g ""']
    " global quick search-replace with ag aka silver_searcher
    nmap <leader>sr :args `ag -l '<C-r>=expand("<cword>")<cr>' .` \|
    \ argdo %s/<C-r>=expand("<cword>")<cr>//gc \| w<left><left><left><left><left><left><left>
  else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neomake_javascript_enabled_makers = ['eslint_d']
autocmd! BufWritePost * Neomake

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
