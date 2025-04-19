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
set hidden       " Allow buffer switching without saving

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
Plug 'flazz/vim-colorschemes'

" Git signs - using vim-gitgutter
Plug 'airblade/vim-gitgutter'

" LSP Support - using coc.nvim for better cross-file navigation
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" =============================================================================
" Colorscheme configuration
colorscheme darcula

" =============================================================================
" Git Gutter configuration
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '~_'
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0

" Git Gutter update interval
let g:gitgutter_max_signs = 500
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" =============================================================================
" COC Configuration for LSP

" Extensions to auto-install
let g:coc_global_extensions = [
  \ 'coc-rust-analyzer',
  \ 'coc-go',
  \ 'coc-clangd',
  \ 'coc-tsserver',
  \ 'coc-pyright'
  \ ]

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[d` and `]d` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation - these will work across files!
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)

" Apply code actions
nmap <leader>ca  <Plug>(coc-codeaction)

" Use <c-k> for coc action menu 
nmap <c-k> :CocAction<CR>

" Use <leader>d to show diagnostics
nnoremap <leader>d :<C-u>CocList diagnostics<cr>

" Add (Neo)Vim's native statusline support
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

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
inoremap jk <Esc>   
nnoremap <Leader>w :w<CR>   
nnoremap <Leader>q :q<CR>   
nnoremap <Leader>e :Explore<CR>   
vnoremap <Leader>y "+y   
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p   

" Git gutter mappings
nnoremap <Leader>gh :GitGutterPreviewHunk<CR>
nnoremap <Leader>gn :GitGutterNextHunk<CR>
nnoremap <Leader>gp :GitGutterPrevHunk<CR>
nnoremap <Leader>gs :GitGutterStageHunk<CR>
nnoremap <Leader>gu :GitGutterUndoHunk<CR>

" =============================================================================
" Fuzzy Finder (fzf.vim) shortcuts
nnoremap <Leader>; :FZF<CR>         
nnoremap <Leader>fw :Rg <C-R><C-W><CR>  
nnoremap <Leader>fg :Rg<CR>           
nnoremap <Leader>s. :History<CR>      
nnoremap <Leader><Leader> :Buffers<CR> 

" =============================================================================
" Markdown Preview mapping
let g:mkdp_filetypes = ['markdown'] " Ensure markdown preview works for markdown files
nnoremap <Leader>mm :MarkdownPreviewToggle<CR>

" Format on save
autocmd BufWritePre * :call CocAction('format')

" =============================================================================
" End of vimrc
" =============================================================================
