" enable viM
set nocompatible

" normal X11 clipboard
set clipboard=unnamedplus

" undo after closing the file
set undofile

set undodir=~/.vim/undodir

" maximum number of changes that can be undone
set undolevels=1000 

" maximum number lines to save for undo on a buffer reload
set undoreload=10000 

" screen lines above and below the cursor
set scrolloff=4 

" visual menu
set wildmenu 

" show file info
set ruler 

" current line, total lines      percentage
set rulerformat=%l,%L%=%P

" navigate over line breaks with h and l
set whichwrap+=<,>,h,l 

" ignore case when searching
set ignorecase 

" don't ignore case when search contains uppercase letters
set smartcase 

" browser-like search
set incsearch 

" 'normal' regular expressions
set magic 

" vi has two modes – 'beep repeatedly' and 'break everything'
set noerrorbells 

" how long to wait for 2+ key combos
set timeoutlen=500 

" show line numbers
set number 

" fold lines at {{ {N marker
set foldmethod=marker 

" default is latin1
set encoding=utf8

" default file types
set fileformats=unix 

" shiftwidth (actually, this is the more important tab setting because of
" expandtab)
set shiftwidth=4

" tabwidth
set tabstop=4 

" replace tabs by spaces
set expandtab 

" break at space/tab/etc
set linebreak 

" keep manual indent
set autoindent 

" syntax indent
set smartindent 

" wrap lines
set wrap 

" command line history
set history=700

" load changed files under certain conditions
set autoread

set spelllang=de,en

call pathogen#infect()
syntax enable
filetype plugin on
filetype indent on

" my color scheme
colorscheme jungle

" automatically reload .vimrc after save
autocmd! BufWritePost .vimrc source ~/.vimrc

" add unsupported filetypes
autocmd! BufRead,BufNewFile *.pro set filetype=prolog
autocmd! BufRead,BufNewFile *.dart set filetype=javascript

" create new lines above and below 
nnoremap <leader>o o<esc><up>
nnoremap <leader>O O<esc><down>

" show the syntax item at the current position (for development of color
" schemes)
nnoremap <c-s-p> :call <sid>SynStack()<cr>
function! <sid>SynStack()
  if !exists("*synstack")
    return
   endif
   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Mappings
let mapleader = "-"

nnoremap <leader>w :w!<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>te :tabedit 
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove 
nnoremap <C-h> :tabprevious<cr>
nnoremap <C-l> :tabnext<cr>
nnoremap <leader>ss :setlocal spell! spelllang=de,en<cr>
nnoremap <leader>ev :vsplit $MYVIMRC

" navigate with tags. see ftplugins/tex.vim
nnoremap <leader>tt :tag 
nnoremap <leader>tp :ptag 
nnoremap <leader>ts :stag 

" move selected lines up or down
nnoremap <c-j> :m+<CR>==
nnoremap <c-k> :m-2<CR>==
inoremap <c-j> <esc>:m+<CR>==gi
inoremap <c-k> <esc>:m-2<CR>==gi
vnoremap <c-j> :m'>+<CR>gv=gv
vnoremap <c-k> :m-2<CR>gv=gv

