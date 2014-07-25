if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   chooConditional match if else
syn keyword   chooOperator    as

syn keyword   chooKeyword     break continue
syn keyword   chooKeyword     for in if while
syn keyword   chooKeyword     return
syn keyword   chooKeyword     import
syn keyword   chooKeyword     struct enum type trait
syn keyword   chooKeyword     fn var map const
syn keyword   chooKeyword     on cont nextgroup=chooEvent skipwhite

" Built-in types {{{2
syn keyword   chooType        int double str event bool

" Core operators {{{3
syn keyword   chooTrait       Share Copy Send Sized
syn keyword   chooEnum        Result
syn keyword   chooEnumVariant Ok Err
syn keyword   chooEnumVariant Some None
syn keyword   chooEnumVariant true false


" Other syntax {{{2
"
syn match     chooModPath     "\w\(\w\)*\ze::[^<]"
syn match     chooModPathSep  "::"

syn match     chooFuncCall    "\w\+\ze("
syn match     chooFuncCall    "\w\+\ze::<" " foo::<T>();

syn match     chooEvent       "\w\+\ze(" contained

" This is merely a convention; note also the use of [A-Z], restricting it to
" latin identifiers rather than the full Unicode uppercase. I have not used
" [:upper:] as it depends upon 'noignorecase'
"syn match     chooCapsIdent    display "[A-Z]\w\(\w\)*"

syn match     chooOperator     display "\%(+\|-\|/\|*\|=\|\^\|&amp;\||\|!\|>\|<\|%\)=\?"

syn match     chooStringContinuation display contained /\\\n\s*/
syn region    chooString      start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=chooSpecial,chooSpecialError,chooStringContinuation,@Spell
syn region    chooString      start='r\z(#*\)"' end='"\z1' contains=@Spell

syn region    chooSelect matchgroup=chooType start="#\w*(" end=")\(::\w\+\)\?" transparent
syn region    Macro matchgroup=chooHTML start="html\s*(" end=")" contains=chooDolVar
syn region    Macro matchgroup=chooHTML start="js\s*(" end=")" transparent
syn region    Macro matchgroup=chooHTML start="css\s*(" end=")" contains=chooDolVar
syn region    Macro matchgroup=chooHTML start="json\s*(" end=")" contains=chooDolVar

syn match     chooDolVar "$\w\+\(\.\w\+\)*" contained

" Number literals
syn match     chooDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(8\|16\|32\|64\)\=\)\="
syn match     chooHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(8\|16\|32\|64\)\=\)\="
syn match     chooBinNumber   display "\<0b[01_]\+\%([iu]\%(8\|16\|32\|64\)\=\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access.
" (This must go first so the others take precedence.)
syn match     chooFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     chooFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     chooFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     chooFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

syn region chooCommentLine                                        start="//"                      end="$"   contains=chooTodo,@Spell
syn region chooCommentLineDoc                                     start="//\%(//\@!\|!\)"         end="$"   contains=chooTodo,@Spell
syn region chooCommentBlock    matchgroup=chooCommentBlock        start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=chooTodo,chooCommentBlockNest,@Spell
syn region chooCommentBlockDoc matchgroup=chooCommentBlockDoc     start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=chooTodo,chooCommentBlockDocNest,@Spell
syn region chooCommentBlockNest matchgroup=chooCommentBlock       start="/\*"                     end="\*/" contains=chooTodo,chooCommentBlockNest,@Spell contained transparent
syn region chooCommentBlockDocNest matchgroup=chooCommentBlockDoc start="/\*"                     end="\*/" contains=chooTodo,chooCommentBlockDocNest,@Spell contained transparent
" FIXME: this is a really ugly and not fully correct implementation. Most
" importantly, a case like ``/* */*`` should have the final ``*`` not being in
" a comment, but in practice at present it leaves comments open two levels
" deep. But as long as you stay away from that particular case, I *believe*
" the highlighting is correct. Due to the way Vim's syntax engine works
" (greedy for start matches, unlike choo's tokeniser which is searching for
" the earliest-starting match, start or end), I believe this cannot be solved.
" Oh you who would fix it, don't bother with things like duplicating the Block
" rules and putting ``\*\@<!`` at the start of them; it makes it worse, as
" then you must deal with cases like ``/*/**/*/``. And don't try making it
" worse with ``\%(/\@<!\*\)\@<!``, either...

syn keyword chooTodo contained TODO FIXME XXX NB NOTE

" Folding rules {{{2
" Trivial folding rules to begin with.
" TODO: use the AST to make really good folding
syn region chooFoldBraces start="{" end="}" transparent fold
" If you wish to enable this, setlocal foldmethod=syntax
" It's not enabled by default as it would drive some people mad.

" Default highlighting {{{1
hi def link chooDecNumber       chooNumber
hi def link chooHexNumber       chooNumber
hi def link chooOctNumber       chooNumber
hi def link chooBinNumber       chooNumber
hi def link chooIdentifierPrime chooIdentifier
hi def link chooTrait           chooType

hi def link chooSigil         StorageClass
hi def link chooSpecial       Special
hi def link chooSpecialError  Error
hi def link chooStringContinuation Special
hi def link chooString        String
hi def link chooCharacter     Character
hi def link chooNumber        Number
hi def link chooBoolean       Boolean
hi def link chooEnum          chooType
hi def link chooEnumVariant   chooConstant
hi def link chooConstant      Constant
hi def link chooSelf          Constant
hi def link chooFloat         Float
hi def link chooOperator      Operator
hi def link chooKeyword       Keyword
hi def link chooReservedKeyword Error
hi def link chooConditional   Conditional
hi def link chooIdentifier    Identifier
hi def link chooCapsIdent     chooIdentifier
hi def link chooModPath       Include
hi def link chooModPathSep    Delimiter
hi def link chooFunction      Function
hi def link chooFuncName      Function
hi def link chooFuncCall      Function
hi def link chooCommentLine   Comment
hi def link chooCommentLineDoc SpecialComment
hi def link chooCommentBlock  chooCommentLine
hi def link chooCommentBlockDoc chooCommentLineDoc
hi def link chooAssert        PreCondit
hi def link chooFail          PreCondit
hi def link chooMacro         Macro
hi def link chooType          Type
hi def link chooTodo          Todo
hi def link chooAttribute     PreProc
hi def link chooDeriving      PreProc
hi def link chooStorage       StorageClass
hi def link chooObsoleteStorage Error
hi def link chooLifetime      Special
hi def link chooInvalidBareKeyword Error
hi def link chooExternCrate   chooKeyword
hi def link chooObsoleteExternMod Error
hi def link chooEvent Macro
hi def link chooHTML chooKeyword
hi def link chooDolVar chooIdentifier

" Other Suggestions:
" hi chooAttribute ctermfg=cyan
" hi chooDeriving ctermfg=cyan
" hi chooAssert ctermfg=yellow
" hi chooFail ctermfg=red
" hi chooMacro ctermfg=magenta

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "choo"
