" =============================================================================
" Leader key setup
let mapleader = " "
let maplocalleader = " "

" =============================================================================
" Core options
set relativenumber
set number
set mouse=a
set colorcolumn=80
set showmode      " Keep showmode as it's standard vim
set wrap
set breakindent
set linebreak
set showbreak=>>\ 
set textwidth=80
set undofile
set ignorecase
set smartcase
set signcolumn=yes
set updatetime=100
set timeoutlen=300  " Increased from 100 to give more time for mappings
set splitright
set splitbelow
set list
set listchars=tab:»\ ,trail:·,nbsp:␣
set scrolloff=10
set confirm
set tabstop=2
set shiftwidth=2
set expandtab

" =============================================================================
" Plugin Manager: vim-plug
" Install vim-plug: https://github.com/junegunn/vim-plug
" Example (for Unix-like systems):
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" =============================================================================
call plug#begin('~/.vim/plugged')

" Fuzzy Finder: fzf and fzf.vim
" Requires fzf executable to be installed on your system
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

" Colorscheme
Plug 'doums/darcula'

" Optional: Enhance netrw (Vim's built-in file explorer)
" Plug 'tpope/vim-vinegar'

call plug#end()

" =============================================================================
" Colorscheme configuration
colorscheme darcula

" =============================================================================
" Key mappings
" Use nnoremap, vnoremap, inoremap for non-recursive mappings

" Clear search highlighting
nnoremap <Esc> :nohlsearch<CR>

" Arrow key disablers
nnoremap <left> :echo "Use h to move!!"<CR>
nnoremap <right> :echo "Use l to move!!"<CR>
nnoremap <up> :echo "Use k to move!!"<CR>
nnoremap <down> :echo "Use j to move!!"<CR>

" Window navigation (Standard Vim <C-w> commands)
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Visual mode improvements
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Quality of life mappings
nnoremap o o<Esc>
nnoremap O O<Esc>
inoremap jk <Esc>   " Escape with jk
nnoremap <Leader>w :w<CR>   " Write with leader w
nnoremap <Leader>q :q<CR>   " Added quit mapping
nnoremap <Leader>e :Explore<CR>   " Toggle file explorer (using built-in netrw)
vnoremap <Leader>y "+y   " Yank to system clipboard
nnoremap <Leader>y "+y   " Added normal mode yank to clipboard
nnoremap <Leader>p "+p   " Added paste from clipboard

" =============================================================================
" Fuzzy Finder (fzf.vim) shortcuts

nnoremap <Leader>; :Files<CR>         
nnoremap <Leader>fw :Rg <C-R><C-W><CR>  
nnoremap <Leader>fg :Rg<CR>           
nnoremap <Leader>s. :History<CR>      
nnoremap <Leader><Leader> :Buffers<CR> 

" =============================================================================
" Markdown Preview mapping
let g:mkdp_filetypes = ['markdown'] " Ensure markdown preview works for markdown files
nnoremap <Leader>mm :MarkdownPreviewToggle<CR>

" =============================================================================
" End of vimrc
" =============================================================================
