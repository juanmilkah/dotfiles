" Leader key
let mapleader = " "

" Basic settings
set nocompatible
"set clipboard=unnamedplus
set mouse=a
set confirm

" Display
set number
set relativenumber
set showmode
set showcmd
set laststatus=2

" Indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set breakindent

" Search
set incsearch
set ignorecase
set smartcase
set nohlsearch

" Files and backup
set nobackup
set undofile
filetype on
filetype plugin on
filetype indent on
syntax on

" Performance
set updatetime=250
set timeoutlen=300
set lazyredraw

" Splits
set splitright
set splitbelow

" Key mappings
nnoremap <Esc> :nohlsearch<CR>
nnoremap o o<Esc>
nnoremap O O<Esc>
inoremap jk <Esc>
nnoremap Y y$
nnoremap n nzz
nnoremap N Nzz

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'blueshirts/darcula'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

" Color scheme
set background=dark
colorscheme darcula

" Custom colors
highlight Normal guibg=#181818 ctermbg=234
highlight Comment guifg=#FF8C00 ctermfg=208
highlight LineNr guifg=#FF8C00 ctermfg=208
highlight CursorLineNr guifg=#FFA500 ctermfg=214

" LSP settings
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlight_references_enabled = 1

" LSP key mappings
nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gi <plug>(lsp-implementation)
nmap <silent> gt <plug>(lsp-type-definition)
nmap <silent> gn <plug>(lsp-rename)
nmap <silent> ga <plug>(lsp-code-action)
nmap <silent> K <plug>(lsp-hover)

" Asyncomplete settings
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" FZF mappings
" nnoremap <leader>f :Files<CR>
nnoremap <leader>f :GFiles --cached --others --exclude-standard<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>/ :BLines<CR>

" Simple status line
set statusline=%f\ %m%r%h%w%=%l,%c\ %P
