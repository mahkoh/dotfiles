" Language:     zz
" Description:  Vim syntax file for zz
" Last Change:  Jul 07, 2014

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

setlocal textwidth=90
setlocal colorcolumn=+1
nnoremap <buffer> <leader>G :w !gist rs<cr>
vnoremap <buffer> <leader>G :w !gist rs<cr>

let s:save_cpo = &cpo
set cpo&vim

" Variables {{{1

" The zz source code at present seems to typically omit a leader on /*!
" comments, so we'll use that as our default, but make it easy to switch.
" This does not affect indentation at all (I tested it with and without
" leader), merely whether a leader is inserted by default or not.
if exists("g:zz_bang_comment_leader") && g:zz_bang_comment_leader == 1
	" Why is the `,s0:/*,mb:\ ,ex:*/` there, you ask? I don't understand why,
	" but without it, */ gets indented one space even if there were no
	" leaders. I'm fairly sure that's a Vim bug.
	setlocal comments=s1:/*,mb:*,ex:*/,s0:/*,mb:\ ,ex:*/,:///,://!,://
else
	setlocal comments=s0:/*!,m:\ ,ex:*/,s1:/*,mb:*,ex:*/,:///,://!,://
endif
setlocal commentstring=//%s
setlocal formatoptions-=t formatoptions+=croqnl
" j was only added in 7.3.541, so stop complaints about its nonexistence
silent! setlocal formatoptions+=j

" smartindent will be overridden by indentexpr if filetype indent is on, but
" otherwise it's better than nothing.
setlocal smartindent nocindent

setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" This includeexpr isn't perfect, but it's a good start
setlocal includeexpr=substitute(v:fname,'::','/','g')

" NOT adding .rc as it's being phased out (0.7)
setlocal suffixesadd=.rs

if exists("g:ftplugin_zz_source_path")
    let &l:path=g:ftplugin_zz_source_path . ',' . &l:path
endif

if exists("g:loaded_delimitMate")
	if exists("b:delimitMate_excluded_regions")
		let b:zz_original_delimitMate_excluded_regions = b:delimitMate_excluded_regions
	endif
	let b:delimitMate_excluded_regions = delimitMate#Get("excluded_regions") . ',zzLifetimeCandidate,zzGenericLifetimeCandidate'
endif

if has("folding") && exists('g:zz_fold') && g:zz_fold != 0
	let b:zz_set_foldmethod=1
	setlocal foldmethod=syntax
	if g:zz_fold == 2
		setlocal foldlevel<
	else
		setlocal foldlevel=99
	endif
endif

if has('conceal') && exists('g:zz_conceal')
	let b:zz_set_conceallevel=1
	setlocal conceallevel=2
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set noet sw=4 ts=4:
