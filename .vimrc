" Enable viM
set nocompatible

" Normal X11 clipboard
set clipboard=unnamedplus

" Undo after closing the file
set undofile

set undodir=~/.vim/undodir

"maximum number of changes that can be undone
set undolevels=1000 

"maximum number lines to save for undo on a buffer reload
set undoreload=10000 

" Screen lines above and below the cursor
set scrolloff=4 

" Visual Menu
set wildmenu 

" Show file info
set ruler 

" Current line, Total lines      Percentage
set rulerformat=%l,%L%=%P

" Navigate over line breaks with h and l
set whichwrap+=<,>,h,l 

" Ignore case when searching
set ignorecase 

" Don't ignore case when it contains uppercase letter
set smartcase 

" Dynamic search
set incsearch 

" Easy regular expressions
set magic 

" vi has two modes – 'beep repeatedly' and 'break everything'
set noerrorbells 

" How long to wait for 2+ key combos
set timeoutlen=500 

" Show line numbers
set number 

" Fold lines at {{ {N marker
set foldmethod=marker 

" Default is latin1
set encoding=utf8

" Default file types
set fileformats=unix 

" Shiftwidth
set shiftwidth=4

" Tabwidth
set tabstop=4 

" Replace tabs by spaces
set expandtab 

" Break at space/tab/etc
set linebreak 

" Auto indent
set autoindent 

" Smart indet
set smartindent 

" Wrap lines
set wrap 

" Command line history
set history=700

" Load changed files under certain conditions
set autoread

set spelllang=de,en

" my sane color scheme
colorscheme 256-jungle

syntax enable
filetype plugin on
filetype indent on

autocmd! BufWritePost .vimrc source ~/.vimrc
autocmd! BufRead,BufNewFile *.pro set filetype=prolog
autocmd! BufRead,BufNewFile *.dart set filetype=javascript

" Create new lines above and below 
nnoremap <Leader>o o<Esc><Up>
nnoremap <Leader>O O<Esc><Down>

" Show the syntax item at the current position
nnoremap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
   endif
   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Mappings
let mapleader = "-"

nnoremap <leader>w :w!<cr>
nnoremap <leader>e :e! ~/.vim_runtime/vimrc<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>te :tabedit 
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove 
nnoremap <C-h> :tabprevious<cr>
nnoremap <C-l> :tabnext<cr>
nnoremap <c-j> :m+<CR>==
nnoremap <c-k> :m-2<CR>==
nnoremap <leader>ss :setlocal spell! spelllang=de,en<cr>
nnoremap <leader>ev :vsplit $MYVIMRC
nnoremap <leader>tt :tag 
nnoremap <leader>tp :ptag 
nnoremap <leader>ts :stag 

inoremap <c-j> <Esc>:m+<CR>==gi
inoremap <c-k> <Esc>:m-2<CR>==gi

vnoremap <c-j> :m'>+<CR>gv=gv
vnoremap <c-k> :m-2<CR>gv=gv

