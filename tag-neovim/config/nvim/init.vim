let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

call plug#begin('~/.local/share/nvim/plugged')
Plug 'reasonml-editor/vim-reason-plus'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'roxma/nvim-completion-manager'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
call plug#end()

let g:LanguageClient_serverCommands = {
            \ 'javascript': ['javascript-typescript-stdio'],
            \ 'typescript': ['javascript-typescript-stdio'],
            \ 'reason': ['ocaml-language-server', '--stdio'],
            \ 'ocaml': ['ocaml-language-server', '--stdio'],
            \ }

let g:LanguageClient_autoStart = 1

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

colorscheme onedark
set noshowmode

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500

set ai si wrap
