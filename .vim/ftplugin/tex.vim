" compile
nnoremap <buffer> <F2> :w<cr>:! xelatex %<cr><cr>
nmap <buffer> <leader>jj <F2>
imap <buffer> <F2> <esc><F2>

" show
" NOTE: 2> /dev/null doesn't work! fix this
nnoremap <F3> :! evince %:r.pdf > /dev/null 2> /dev/null &<cr><cr>

" create bibtex files
nnoremap <F4> :! bibtex %:r <cr><cr>

" create hdrtags for quick navigation
nnoremap <leader>kk :w<cr>:! hdrtag %<cr>:set tags=./tags<cr>

" edit tex syntax file
nnoremap <leader>es :tabedit ~/.vim/syntax/tex.vim<cr>

" edit tex plugin file
nnoremap <leader>ep :tabedit ~/.vim/ftplugin/tex.vim<cr>

" reload after edit
autocmd! BufWritePost ~/.vim/ftplugin/tex.vim source ~/.vim/ftplugin/tex.vim

" tab -> autocomplete
inoremap <Tab> <c-n>

set showbreak=▶▶\ 

" latex looks best with two spaces as tabs
" do I even use this?
set shiftwidth=2

set scrolloff=7

" I use my own indent
set nosmartindent
filetype indent off

iab farc frac

" we don't use \[ and \] anymore
iab \[ \begin{align*}<cr> 
iab \] <left><left>\end{align*}
