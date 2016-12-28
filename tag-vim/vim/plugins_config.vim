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
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_javascript_eslint_args = '--fix'

let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
