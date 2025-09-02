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
set signcolumn=no
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

" Key mappings (small, useful defaults)
nnoremap <Esc> :nohlsearch<CR>
nnoremap o o<Esc>
nnoremap O O<Esc>
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

" " File tree (lightweight)
" Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-git-status.vim'

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

" ---------------------------
" Colorscheme
" ---------------------------
set background=dark
if has('termguicolors')
  set termguicolors
endif
colorscheme gruber

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

" File explorer (fern)
" nnoremap <leader>e :Fern . -reveal=% -drawer -toggle<CR>

" ---------------------------
" Go-to-definition support
" ---------------------------
" Option A — ctags (lightweight, reliable for many languages)
" Use: install universal-ctags, run `ctags -R .` in project root.
" Jump to symbol under cursor with <C-]>, back with <C-t>.
" set tags+=./tags;

" Option B — vim-lsp (more accurate; enable servers via vim-lsp-settings)
" Mappings for vim-lsp (active when server attached)
nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gi <plug>(lsp-implementation)
nmap <silent> gt <plug>(lsp-type-definition)
nmap <silent> gn <plug>(lsp-rename)
nmap <silent> ga <plug>(lsp-code-action)
nmap <silent> K  <plug>(lsp-hover)

" If you prefer ALE for linting/formatting instead of LSP completion, plug it and configure accordingly.

" ALE (optional) — keep visual noise low
" Plug 'dense-analysis/ale'
" let g:ale_fix_on_save = 1
" let g:ale_linters_explicit = 1
" let g:ale_virtualtext_cursor = 0
" let g:ale_echo_cursor = 0
" let g:ale_set_signs = 1
" let g:ale_set_highlights = 0
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 1

" asyncomplete mappings (completion)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" --- Format on save using vim-lsp ---
" Only try formatting if the server attached to the buffer provides formatting.
function! s:format_if_supported() abort
  if !exists('*lsp#buf#request_sync')
    return
  endif
  " query server capabilities for documentRangeFormatting or documentFormatting
  let l:clients = lsp#get_active_clients({'bufnr': bufnr('%')})
  if empty(l:clients)
    return
  endif
  for client in l:clients
    if has_key(client['serverCapabilities'], 'documentFormattingProvider') && client['serverCapabilities']['documentFormattingProvider']
      call lsp#buf#request_sync(bufnr('%'), 'textDocument/formatting', lsp#util#make_text_document_params(), 2000)
      return
    endif
    if has_key(client['serverCapabilities'], 'documentRangeFormattingProvider') && client['serverCapabilities']['documentRangeFormattingProvider']
      " range-format entire document
      let l:range = {'start': {'line': 0, 'character': 0}, 'end': {'line': line('$') - 1, 'character': 0}}
      call lsp#buf#request_sync(bufnr('%'), 'textDocument/rangeFormatting', {'textDocument': lsp#util#make_text_document_params().textDocument, 'range': l:range, 'options': {}}, 2000)
      return
    endif
  endfor
endfunction

augroup LspFormatOnSave
  autocmd!
  " run formatting before buffer is written
  autocmd BufWritePre * call s:format_if_supported()
augroup END
