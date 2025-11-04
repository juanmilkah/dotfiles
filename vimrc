" Leader key
let mapleader = ' '

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

set textwidth=100
set cc=+1
set formatoptions+=t   " auto-wrap text when typing (textwidth)
set wrap               " visual wrapping for long lines
set linebreak          " break at word boundaries when displaying wrapped lines
set nolist             " avoid showing tabs/ends that confuse wrapping

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
set dir=~/dev/tmp

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
Plug 'dense-analysis/ale'

" Optional quality-of-life
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'

Plug 'flazz/vim-colorschemes'

call plug#end()

" set scrolloff=5
set signcolumn=yes

" ---------------------------
" Colorscheme
" ---------------------------
set background=dark
if has('termguicolors')
  set termguicolors
endif
"...
colorscheme gruvbox
" Disable error highlighting
highlight! link LspErrorText Normal
highlight! link LspErrorLine Normal
highlight! link LspWarningText Normal
highlight! link LspWarningLine Normal
highlight! link LspInformationText Normal
highlight! link LspInformationLine Normal
highlight! link LspHintText Normal
highlight! link LspHintLine Normal

" Clear error sign column colors
highlight! LspErrorHighlight guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
highlight! LspWarningHighlight guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
highlight! LspInformationHighlight guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
highlight! LspHintHighlight guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE

" Keep error signs but make them subtle (optional)
highlight! LspErrorText guifg=#555555 ctermfg=240
highlight! LspWarningText guifg=#555555 ctermfg=240

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
nnoremap <leader>f :GFiles --cached --others --exclude-standard<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>/ :BLines<CR>

" Mappings for vim-lsp (active when server attached)
"nmap <silent> gd <plug>(lsp-definition)
"nmap <silent> gr <plug>(lsp-references)
"nmap <silent> gi <plug>(lsp-implementation)
"nmap <silent> gt <plug>(lsp-type-definition)
"nmap <silent> gn <plug>(lsp-rename)
"nmap <silent> ga <plug>(lsp-code-action)
"nmap <silent> K  <plug>(lsp-hover)
"nmap <silent> [d  <plug>(lsp-previous-diagnostic)
"nmap <silent> ]d  <plug>(lsp-next-diagnostic)

let g:ale_completion_enabled = 1
let g:ale_hover_to_preview = 1
" Hover behavior
let g:ale_hover_cursor = 1
let g:ale_hover_to_preview = 0
let g:ale_hover_to_floating_preview = 1
let g:ale_floating_preview = 1
let g:ale_detail_to_floating_preview = 1

set completeopt=menu,menuone,preview,noinsert,noselect
let g:ale_completion_delay = 0
let g:ale_completion_max_suggestions = 50

let g:ale_fix_on_save = 1

" ALE keybindings
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gr :ALEFindReferences<CR>
nmap <silent> gi :ALEGoToImplementation<CR>
nmap <silent> gt :ALEGoToTypeDefinition<CR>
nmap <silent> K :ALEHover<CR>
nmap <silent> gn :ALERename<CR>
nmap <silent> ga :ALECodeAction<CR>
nmap <silent> [e :ALEPrevious<CR>
nmap <silent> ]e :ALENext<CR>
nmap <silent> <leader>d :ALEDetail<CR>

" Tab completion
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" asyncomplete mappings (completion)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

function! LspFormatIfAvailable() abort
  if &modifiable == 0 || expand('%') == ''
    return
  endif
  " Run the synchronous formatter (safe to call even if no formatter; silent avoids messages)
  silent! LspDocumentFormatSync
endfunction

augroup AutoLspFormatOnSave
  autocmd!
  autocmd BufWritePre * nested call LspFormatIfAvailable()
augroup END

" Use Vim's built-in numbered menu
let g:lsp_code_action_ui = 'float'

function! LspCodeActionPrompt() abort
    let l:diagnostics = lsp#get_buffer_diagnostics()
    call lsp#ui#vim#code_action()
endfunction

" Better: Let vim-lsp handle it but configure the UI
let g:lsp_diagnostics_float_cursor = 1
