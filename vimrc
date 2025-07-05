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
 set signcolumn=no          " 🔇 no grey sign column by default
 set noshowmatch

 " Indentation
 set tabstop=2
 set shiftwidth=2
 set softtabstop=2
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
 set undofile
 set autoread
 filetype plugin indent on
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
  noremap Y y$
  noremap n nzz
  noremap N Nzz
  noremap < <gv
  noremap > >gv

 " Plugins
 call plug#begin('~/.vim/plugged')

 " Finder & file tree
 Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
 Plug 'junegunn/fzf.vim'
 Plug 'lambdalisue/fern.vim'

 " Git + Statusline
 Plug 'tpope/vim-fugitive'

 " Linting, formatting, LSP
 Plug 'dense-analysis/ale'
 Plug 'prabirshrestha/vim-lsp'
 Plug 'mattn/vim-lsp-settings'
 Plug 'prabirshrestha/asyncomplete.vim'
 Plug 'prabirshrestha/asyncomplete-lsp.vim'

 " Quality of life
 Plug 'airblade/vim-gitgutter'
 Plug 'jiangmiao/auto-pairs'
 Plug 'tpope/vim-commentary'

 " Theme
 Plug 'blueshirts/darcula'
Plug 'ayu-theme/ayu-vim' 
 call plug#end()

 " Theme and colors
set background=dark
set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

 highlight Normal guibg=#181818 ctermbg=234
 highlight Comment guifg=#FF8C00 ctermfg=208
 highlight LineNr guifg=#FF8C00 ctermfg=208
 highlight CursorLineNr guifg=#FFA500 ctermfg=214

 " Statusline with Git branch
 set statusline=%f\ %m%r%h%w\ [%{FugitiveHead()}]%=%l:%c\ %P

 " FZF keybindings
 nnoremap <leader>; :GFiles --cached --others --exclude-standard<CR>
 nnoremap <leader>fg :Rg<CR>
 nnoremap <leader>/ :BLines<CR>

 " File explorer (fern)
 nnoremap <leader>e :Fern . -reveal=% -drawer -toggle<CR>

 " LSP Key mappings
 nmap <silent> gd <plug>(lsp-definition)
 nmap <silent> gr <plug>(lsp-references)
 nmap <silent> gi <plug>(lsp-implementation)
 nmap <silent> gt <plug>(lsp-type-definition)
 nmap <silent> gn <plug>(lsp-rename)
 nmap <silent> ga <plug>(lsp-code-action)
 nmap <silent> K <plug>(lsp-hover)

 " ALE: Better inline errors, no visual noise
 let g:ale_fix_on_save = 1
 let g:ale_fixers = {
 \   'rust': ['rustfmt'],
 \   'c': ['clang-format'],
 \   'cpp': ['clang-format'],
 \   'lua': ['stylua'],
 \   'zig': ['zigfmt'],
 \}
 let g:ale_linters_explicit = 1
 let g:ale_virtualtext_cursor = 0
 let g:ale_virtualtext_prefix = '>> '
 let g:ale_echo_cursor = 0
 let g:ale_set_signs = 1
 let g:ale_set_highlights = 0
 let g:ale_virtualtext_color = 'None'
 let g:ale_lint_on_text_changed = 'never'
 let g:ale_lint_on_insert_leave = 1

 " Asyncomplete
 inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
 inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
 inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
