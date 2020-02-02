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
Plug 'styled-components/vim-styled-components', { 'branch': 'main' } | Plug 'hail2u/vim-css3-syntax'
Plug 'jparise/vim-graphql'
Plug 'brooth/far.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

call plug#end()

filetype plugin indent on

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsUsePythonVersion = 3

set conceallevel=2 concealcursor=niv
set hidden
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2

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

let g:coc_global_extensions = [
  \ 'coc-tslint-plugin',
  \ 'coc-tsserver',
  \ 'coc-emmet',
  \ 'coc-snippets',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-yank',
  \ 'coc-prettier',
  \ 'coc-styled-components',
  \ 'coc-flow']

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 ESlint :CocCommand eslint.executeAutofix
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
