" Vim syntax file
" Language:	   lrsb
" Maintainer:  Julian Orth <ju.orth@gmail.com>
" Last Change: 2015-06-29

if exists("b:current_syntax")
  finish
endif

syn keyword	lrsbKeyword	let in inherit rec
syn keyword lrsbBool true false null
syn keyword	lrsbConditional	if else then
syn match lrsbDelimiter "(\|)\|,\|\[\|\]\|;\|\."
syn match lrsbOperator "=\|!=\|==\|<=\|<\|>=\|>\|\.\.\|@\|:\|?\|&\||\|\\\\"

syn region lrsbSet matchgroup=lrsbDelimiter start=+{+ end=+}+ contains=ALL
syn region lrsbString start=+"+ skip=+\\"+ end=+"+ contains=lrsbInterp,lrsbEsc,lrsbEscErr
syn match lrsbIdentDef "\w\+\ze\s*="
syn match lrsbFuncArg "\w\+\ze\s*[:@]"
syn match lrsbComment "//.*$"
syn match lrsbPath "\w\+\s*\."he=e-1,me=e-1
syn match lrsbDigit "\d"
syn match lrsbEscErr "\\." contained
syn match lrsbEsc "\\\(\\\|\"\|n\|t\|d\|u{\x\{1,6}}\)" contained
syn region lrsbInterp matchgroup=lrsbDelimiter start=+\\{+ end=+}+ contained contains=ALL

hi def link lrsbKeyword     Keyword
hi def link lrsbConditional Conditional
hi def link lrsbBool        Boolean
hi def link lrsbOperator    Operator
hi def link lrsbDelimiter   Delimiter
hi def link lrsbBraces      Delimiter
hi def link lrsbString      String
hi def link lrsbDigit       Number
hi def link lrsbPath        Include
hi def link lrsbComment     Comment
hi def link lrsbIdentDef    Identifier
hi def link lrsbFuncArg     Identifier
hi def link lrsbPat         Identifier
hi def link lrsbEsc         Special
hi def link lrsbEscErr      Error

let b:current_syntax = "lrsb"
