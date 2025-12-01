let mapleader = " "
let maplocalleader = " "

set nocompatible
set mouse=a
set confirm
set hidden
set clipboard=unnamedplus
set autoread
set updatetime=300
set timeoutlen=400
set lazyredraw
set shortmess+=c

set number relativenumber
set signcolumn=yes 
" set colorcolumn=+1
set textwidth=80
set formatoptions=tcroqjnl " Better auto-formatting
set wrap linebreak
set listchars=tab:→\ ,trail:·,nbsp:␣
set nolist
set scrolloff=5
set sidescrolloff=10

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent
set breakindent

set incsearch
set ignorecase smartcase
set hlsearch
nnoremap <Esc> :nohlsearch<CR>

" --------------------- Splits & Windows ---------------------
set splitbelow splitright
set winminheight=1
set equalalways eadirection=both

" --------------------- Key Remappings ---------------------
nnoremap Y y$
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
inoremap jk <Esc>
inoremap <C-c> <Esc>

" Visual shifting (keep selection)
vnoremap < <gv
vnoremap > >gv

" --------------------- Plugins (vim-plug) ---------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/drsooch/gruber-darker-vim'

" Core UX
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'

" LSP & Completion (modern lightweight stack)
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'       " Auto-install language servers
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

" --------------------- Colors & Theme ---------------------
" set background=dark
" set termguicolors

colorscheme GruberDarker

highlight LineNr guifg=#FF8C00 ctermfg=208
highlight CursorLineNr guifg=#FFA500 ctermfg=214
highlight Comment guifg=#FF8C00 ctermfg=208
"
" Subtle sign column that matches background but shows signs
highlight SignColumn       guibg=#1c1c1c
" highlight GitGutterAdd     guifg=#00ff00 guibg=#1c1c1c
" highlight GitGutterChange  guifg=#ffff00 guibg=#1c1c1c
" highlight GitGutterDelete  guifg=#ff2222 guibg=#1c1c1c

" LSP diagnostic signs (subtle but visible)
highlight LspErrorText     guifg=#ff5555
highlight LspWarningText   guifg=#ffaa00
highlight LspHintText      guifg=#00ffff
highlight LspInfoText      guifg=#55aaff

" --------------------- vim-lsp Configuration ---------------------
let g:lsp_settings_filetype_go = 'gopls'
let g:lsp_settings_filetype_rust = 'rust-analyzer'
let g:lsp_settings_filetype_cpp = 'clangd'
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_hover_ui = 'float'
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_code_action_ui = 'float'
let g:lsp_diagnostics_float_cursor = 1

highlight LspDiagnosticsVirtualTextError   guifg=#ff6c6b guibg=#3f1f22
highlight LspDiagnosticsVirtualTextWarning guifg=#ffb86c guibg=#3f2f1f
highlight LspDiagnosticsVirtualTextInformation guifg=#82aaff guibg=#1f2f3f
highlight LspDiagnosticsVirtualTextHint   guifg=#4fd6be guibg=#1f3f3a

" Auto-format on save (where formatter exists)
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal completeopt=menu,menuone,noinsert,noselect

    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gD <plug>(lsp-declaration)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> gn <plug>(lsp-rename)
    nmap <buffer> ga <plug>(lsp-code-action)
    nmap <buffer> K  <plug>(lsp-hover)
    nmap <buffer> [e <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]e <plug>(lsp-next-diagnostic)

    " Auto-format on save
    autocmd BufWritePre <buffer> LspDocumentFormatSync --servers ALL
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" --------------------- Completion (asyncomplete) ---------------------
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" --------------------- FZF Keybindings ---------------------
nnoremap <leader>g  :GFiles<CR>
nnoremap <leader>f  :Files<CR>
nnoremap <leader>b  :Buffers<CR>
nnoremap <leader>rg :Rg<Space>
nnoremap <leader>/  :BLines<CR>
nnoremap <leader>H  :History<CR>

set statusline=%f\ %m%r%h%w\ [%{FugitiveHead()}]%=%l:%c\ %P

" --------------------- Wayland clipboard (if available) ---------------------
if executable('wl-copy')
    vnoremap <C-c> :w !wl-copy<CR><CR>
endif
