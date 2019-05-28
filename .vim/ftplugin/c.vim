if (&ft != 'c')
    finish
endif

setlocal noexpandtab
setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal textwidth=80
setlocal colorcolumn=+1
setlocal cinoptions=:0
setlocal hlsearch

sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

nnoremap <buffer> <leader>G :w !gist c<cr>
vnoremap <buffer> <leader>G :w !gist c<cr>
