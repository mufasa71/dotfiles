set nocompatible
filetype off

let mapleader=","                    

call plug#begin('~/.local/share/nvim/plugged')

Plug '/usr/bin/fzf' | Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-rhubarb'

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'ryanoasis/vim-devicons'

Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-entire' | Plug 'kana/vim-textobj-user'
Plug 'othree/yajs.vim' | Plug 'HerringtonDarkholme/yats.vim' | Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'moll/vim-bbye'
Plug 'google/vim-searchindex'
Plug 'tommcdo/vim-exchange'
Plug 'chilicuil/vim-sprunge'
Plug 'lifepillar/vim-cheat40'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' } | Plug 'hail2u/vim-css3-syntax'
" Plug 'jparise/vim-graphql'
" Plug 'galooshi/vim-import-js'
Plug 'brooth/far.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

filetype plugin indent on

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsUsePythonVersion = 3

set conceallevel=2 concealcursor=niv
set hidden

let g:airline_theme='oceanicnext'
nmap <leader>t :Files<CR>
nmap <leader>b :Buffers<CR>
map <leader>q :Bdelete<cr>
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>T  <Plug>(coc-codeaction)
nmap <leader>T  <Plug>(coc-codeaction)

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext
set expandtab
set smarttab
set shiftwidth=2
set tabstop=4
set linebreak
set textwidth=500
set number
set autoindent ai wrap
set encoding=UTF-8
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

if (has("termguicolors"))
  set termguicolors
endif

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 ESlint :CocCommand eslint.executeAutofix
