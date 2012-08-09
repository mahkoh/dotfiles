nnoremap <F2> :w:! xelatex %<cr><cr>
nnoremap <F3> :! zathura %:r.pdf > /dev/null 2> /dev/null &<cr><cr>
nnoremap <F4> :! bibtex %:r <cr><cr>
nnoremap <F5> :w:! hdrtag %:set tags=./tags
imap <F2> <F2>
set showbreak=▶▶\ 
"colorscheme ekvoli
set virtualedit=onemore
set shiftwidth=2
set so=7
NoMatchParen
"set noautoindent
set nosi
filetype indent off

imap <Tab> <c-n>

nnoremap <leader>jj :w:! xelatex %<cr><cr>
nnoremap <leader>kk :w:! hdrtag %:set tags=./tags

iab farc frac
iab \[ \begin{align*} 
iab \] ODOD\end{align*}
