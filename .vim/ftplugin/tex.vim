" compile
nnoremap <F2> :w<cr>:! xelatex %<cr><cr>
nmap <leader>jj i<F2>
imap <F2> <esc><F2>

" show
" NOTE: 2> /dev/null doesn't work! fix this
nnoremap <F3> :! zathura %:r.pdf > /dev/null 2> /dev/null &<cr><cr>

" create bibtex files
nnoremap <F4> :! bibtex %:r <cr><cr>

" create hdrtags for quick navigation
nnoremap <leader>kk :w<cr>:! hdrtag %<cr>:set tags=./tags<cr>

" tab -> autocomplete
inoremap <Tab> <c-n>

" vim is slow as hell. don't match parentheses
NoMatchParen

set showbreak=▶▶\ 

" add space after last character of the line
set virtualedit=onemore

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
