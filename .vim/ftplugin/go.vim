set noexpandtab
nnoremap <buffer> <leader>jj :w<cr>:! go run %<cr><cr>

" save unused variabes
nnoremap <buffer> <leader>gu mayiw?^func<cr>f{%O_ = <esc>p`a
" clean unused variabes
nnoremap <buffer> <leader>gc ma?^func<cr>f{v%:g/^\s*_/d<cr>`a
