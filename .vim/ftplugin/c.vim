setlocal noexpandtab
setlocal tabstop=8
setlocal shiftwidth=8

sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

nnoremap <buffer> <leader>G :w !gist c<cr>
vnoremap <buffer> <leader>G :w !gist c<cr>
