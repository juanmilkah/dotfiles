" Leader key
let mapleader = " "

" Basic settings
set nocompatible
set mouse=a
set confirm
set hidden
set clipboard=unnamedplus

" Display
set number
set relativenumber
set showmode
set showcmd
set laststatus=2
set noshowmatch

set textwidth=80
set formatoptions+=t   " auto-wrap text when typing (textwidth)
set wrap               " visual wrapping for long lines
set linebreak          " break at word boundaries when displaying wrapped lines
set nolist             " avoid showing tabs/ends that confuse wrapping

" Indentation
set tabstop=8
set shiftwidth=8
set softtabstop=8
set expandtab
set breakindent
set autoindent
set smartindent

" Search
set incsearch
set ignorecase
set smartcase
set nohlsearch

" Files and backups
set nobackup
set nowritebackup
set autoread
filetype plugin indent on
syntax on

" Performance
set updatetime=100
set timeoutlen=300
set lazyredraw

" Splits
set splitright
set splitbelow

" Key mappings (small, useful defaults)
nnoremap <Esc> :nohlsearch<CR>
nnoremap o o<Esc>
nnoremap O O<Esc>
inoremap jk <Esc>
noremap Y y$
noremap n nzz
noremap N Nzz
noremap < <gv
noremap > >gv

" ---------------------------
" Plugins via vim-plug
" ---------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Theme
" Finder (fzf requires ripgrep for best results)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" LSP & completion (minimal for Vim)
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'       " helper to auto-install servers
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Optional quality-of-life
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'

call plug#end()

set scrolloff=10
set signcolumn=yes

" ---------------------------
" Colorscheme
" ---------------------------
set background=dark
if has('termguicolors')
  set termguicolors
endif
colorscheme gruber

" Make the sign column black
if has("termguicolors")
  hi SignColumn guibg=#000000 guifg=NONE
else
  hi SignColumn ctermbg=0 ctermfg=NONE
endif

" Small highlight tweaks (optional)
highlight LineNr guifg=#FF8C00 ctermfg=208
highlight CursorLineNr guifg=#FFA500 ctermfg=214
highlight Comment guifg=#FF8C00 ctermfg=208

" Statusline with git branch
set statusline=%f\ %m%r%h%w\ [%{FugitiveHead()}]%=%l:%c\ %P

" FZF keybindings
nnoremap <leader>; :GFiles --cached --others --exclude-standard<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>/ :BLines<CR>

" Mappings for vim-lsp (active when server attached)
nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gi <plug>(lsp-implementation)
nmap <silent> gt <plug>(lsp-type-definition)
nmap <silent> gn <plug>(lsp-rename)
nmap <silent> ga <plug>(lsp-code-action)
nmap <silent> K  <plug>(lsp-hover)
nmap <silent> [d  <plug>(lsp-previous-diagnostic)
nmap <silent> ]d  <plug>(lsp-next-diagnostic)
" Formatting the document
nnoremap <leader>ff :LspDocumentFormat<CR>

" asyncomplete mappings (completion)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
