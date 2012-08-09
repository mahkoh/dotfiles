nmap <F2> :w:! texexec --xtx %<cr><cr>
nmap <F3> :! evince %:r.pdf 2> /dev/null &<cr><cr>
imap <F2> <F2>
"colorscheme ekvoli
set virtualedit=onemore
set so=7
setlocal noautoindent
set nosi
filetype indent off

imap <Tab> <c-n>
