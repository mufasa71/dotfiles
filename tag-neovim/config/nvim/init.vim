let mapleader=","                    

call plug#begin('~/.local/share/nvim/plugged')
Plug 'reasonml-editor/vim-reason-plus'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'leafgarland/typescript-vim'

Plug '/usr/bin/fzf' | Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'

Plug 'airblade/vim-gitgutter'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim' | Plug 'maximbaz/lightline-ale'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-entire' | Plug 'kana/vim-textobj-user'
Plug 'pangloss/vim-javascript' | Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'moll/vim-bbye'
Plug 'google/vim-searchindex'
Plug 'tommcdo/vim-exchange'
Plug 'chilicuil/vim-sprunge'
Plug 'lifepillar/vim-cheat40'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' } | Plug 'hail2u/vim-css3-syntax'
Plug 'jparise/vim-graphql'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'galooshi/vim-import-js'
Plug 'tpope/vim-rhubarb'
Plug 'posva/vim-vue'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

let g:deoplete#enable_at_startup = 1

let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsUsePythonVersion = 3

autocmd FileType javascript.jsx UltiSnipsAddFiletypes javascript-es6-react
let g:vim_jsx_pretty_colorful_config = 1

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""""""""""""""" LSP
" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['npx', 'flow', 'lsp'],
      \ 'javascript.jsx': ['npx', 'flow', 'lsp'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'reason': ['ocaml-language-server', '--stdio'],
      \ 'ocaml': ['ocaml-language-server', '--stdio'],
      \ 'go': ['go-langserver']
      \ }

let g:LanguageClient_rootMarkers = {
      \ 'javascript': ['.flowconfig']
      \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
""""""""""""""""

let g:lightline = {
      \ 'active': {
      \   'left': [[ 'mode', 'paste' ],
      \            [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right':[[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \            ['lineinfo'], ['percent'], [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ],
      \            ],
      \ },
      \ 'component_expand': {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let g:ale_sign_column_always = 1
let g:ale_linters = {
\    'javascript': ['prettier', 'eslint', 'flow'],
\    'vue': ['eslint', 'vls'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'vue': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'reason': ['refmt'],
\}
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_set_loclist = 1

highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)

nmap <leader>t :Files<CR>
nmap <leader>b :Buffers<CR>
map <leader>q :Bdelete<cr>
nmap <leader>p :ALEFix<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:jsx_ext_required = 0
let g:javascript_conceal_null = "ø"
let g:javascript_conceal_arrow_function = "⇒"
let g:sneak#label = 1

colorscheme onedark
set noshowmode

set expandtab
set smarttab
set shiftwidth=2
set tabstop=4
set lbr
set tw=500
set number

set ai si wrap
set backupcopy=yes
