nnoremap <buffer> <leader>jj :w<cr>:! asciidoctor %<cr><cr>

setlocal tw=80
setlocal colorcolumn=+1

setlocal comments=fb:*,fb:-,fb:.,://
setlocal commentstring=//%s

nnoremap <buffer> <leader>u :r !tf<cr>
