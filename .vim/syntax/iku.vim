" Vim syntax file
" Language:     iku

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   ikuConditional match if else
syn keyword   ikuOperator    as

syn keyword   ikuKeyword     break
syn keyword   ikuKeyword     continue
syn keyword   ikuKeyword     library
syn keyword   ikuKeyword     fn nextgroup=ikuFuncName skipwhite skipempty
syn keyword   ikuKeyword     for in if impl let
syn keyword   ikuKeyword     loop proc pub
syn keyword   ikuKeyword     return super
syn keyword   ikuKeyword     virtual where while
syn keyword   ikuUnsafe      unsafe
syn keyword   ikuKeyword     use nextgroup=ikuModPath,ikuModPathInUse skipwhite skipempty
syn keyword   ikuKeyword     mod trait struct enum type nextgroup=ikuIdentifier skipwhite skipempty
syn keyword   ikuStorage     move mut ref static const

syn match     ikuIdentifier  "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match     ikuFuncName    "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained

syn region ikuMacroRepeat matchgroup=ikuMacroRepeatDelimiters start="$(" end=")" contains=TOP nextgroup=ikuMacroRepeatCount
syn match ikuMacroRepeatCount ".\?[*+]" contained
syn match ikuMacroVariable "$\w\+"

" Reserved (but not yet used) keywords {{{2
syn keyword   ikuReservedKeyword alignof be do offsetof priv pure sizeof typeof unsized yield

" Built-in types {{{2
syn keyword   ikuType        Self

syn keyword ikuSelf self
syn keyword ikuBoolean null true false

" Other syntax {{{2

" If foo::bar changes to foo.bar, change this ("::" to "\.").
" If foo::bar changes to Foo::bar, change this (first "\w" to "\u").
syn match     ikuModPath     "\w\(\w\)*::[^<]"he=e-3,me=e-3
syn match     ikuModPathInUse "\w\(\w\)*" contained " only for 'use path;'
syn match     ikuModPathSep  "::"
" ikuModPathInUse is split out from ikuModPath so that :syn-include can get the group list right.

syn match     ikuFuncCall    "\w\(\w\)*("he=e-1,me=e-1
syn match     ikuFuncCall    "\w\(\w\)*::<"he=e-3,me=e-3 " foo::<T>();

" This is merely a convention; note also the use of [A-Z], restricting it to
" latin identifiers rather than the full Unicode uppercase. I have not used
" [:upper:] as it depends upon 'noignorecase'
"syn match     ikuCapsIdent    display "[A-Z]\w\(\w\)*"

syn match     ikuOperator     display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"
" This one isn't *quite* right, as we could have binary-& with a reference
syn match     ikuSigil        display /&\s\+[&~@*][^)= \t\r\n]/he=e-1,me=e-1
syn match     ikuSigil        display /[&~@*][^)= \t\r\n]/he=e-1,me=e-1
" This isn't actually correct; a closure with no arguments can be `|| { }`.
" Last, because the & in && isn't a sigil
syn match     ikuOperator     display "&&\|||"

syn match     ikuMacro       '\w\(\w\)*!' contains=ikuAssert,ikuFail
syn match     ikuMacro       '#\w\(\w\)*' contains=ikuAssert,ikuFail
syn match     ikuQuestionmark '?'

syn match     ikuEscapeError   display contained /\\./
syn match     ikuEscape        display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     ikuEscapeUnicode display contained /\\\(u\x\{4}\|U\x\{8}\)/
syn match     ikuStringContinuation display contained /\\\n\s*/
syn region    ikuString      start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=ikuEscape,ikuEscapeError,ikuStringContinuation
syn region    ikuString      start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=ikuEscape,ikuEscapeUnicode,ikuEscapeError,ikuStringContinuation,@Spell
syn region    ikuString      start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

syn region    ikuAttribute   start="#!\?\[" end="\]" contains=ikuString,ikuDeriving
syn region    ikuDeriving    start="derive(" end=")" contained contains=ikuTrait

" Number literals
syn match     ikuDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\)\=\)\="
syn match     ikuHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\)\=\)\="
syn match     ikuOctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\)\=\)\="
syn match     ikuBinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\)\=\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access.
" (This must go first so the others take precedence.)
syn match     ikuFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     ikuFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     ikuFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     ikuFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

" For the benefit of delimitMate
syn region ikuLifetimeCandidate display start=/&'\%(\([^'\\]\|\\\(['nrt0\\\"]\|x\x\{2}\|u\x\{4}\|U\x\{8}\)\)'\)\@!/ end=/[[:cntrl:][:space:][:punct:]]\@=\|$/ contains=ikuSigil,ikuLifetime
syn region ikuGenericRegion display start=/<\%('\|[^[cntrl:][:space:][:punct:]]\)\@=')\S\@=/ end=/>/ contains=ikuGenericLifetimeCandidate
syn region ikuGenericLifetimeCandidate display start=/\%(<\|,\s*\)\@<='/ end=/[[:cntrl:][:space:][:punct:]]\@=\|$/ contains=ikuSigil,ikuLifetime

"ikuLifetime must appear before ikuCharacter, or chars will get the lifetime highlighting
syn match     ikuLifetime    display "\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*"
syn match   ikuCharacterInvalid   display contained /b\?'\zs[\n\r\t']\ze'/
" The groups negated here add up to 0-255 but nothing else (they do not seem to go beyond ASCII).
syn match   ikuCharacterInvalidUnicode   display contained /b'\zs[^[:cntrl:][:graph:][:alnum:][:space:]]\ze'/
syn match   ikuCharacter   /b'\([^\\]\|\\\(.\|x\x\{2}\)\)'/ contains=ikuEscape,ikuEscapeError,ikuCharacterInvalid,ikuCharacterInvalidUnicode
syn match   ikuCharacter   /'\([^\\]\|\\\(.\|x\x\{2}\|u\x\{4}\|U\x\{8}\)\)'/ contains=ikuEscape,ikuEscapeUnicode,ikuEscapeError,ikuCharacterInvalid

syn region ikuCommentLine                                        start="//"                      end="$"   contains=ikuTodo,ikuSafe,@Spell
syn region ikuCommentLineDoc                                     start="//\%(//\@!\|!\)"         end="$"   contains=ikuTodo,ikuSafe,@Spell
syn region ikuCommentBlock    matchgroup=ikuCommentBlock        start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=ikuTodo,ikuSafe,ikuCommentBlockNest,@Spell
syn region ikuCommentBlockDoc matchgroup=ikuCommentBlockDoc     start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=ikuTodo,ikuSafe,ikuCommentBlockDocNest,@Spell
syn region ikuCommentBlockNest matchgroup=ikuCommentBlock       start="/\*"                     end="\*/" contains=ikuTodo,ikuSafe,ikuCommentBlockNest,@Spell contained transparent
syn region ikuCommentBlockDocNest matchgroup=ikuCommentBlockDoc start="/\*"                     end="\*/" contains=ikuTodo,ikuSafe,ikuCommentBlockDocNest,@Spell contained transparent
" FIXME: this is a really ugly and not fully correct implementation. Most
" importantly, a case like ``/* */*`` should have the final ``*`` not being in
" a comment, but in practice at present it leaves comments open two levels
" deep. But as long as you stay away from that particular case, I *believe*
" the highlighting is correct. Due to the way Vim's syntax engine works
" (greedy for start matches, unlike iku's tokeniser which is searching for
" the earliest-starting match, start or end), I believe this cannot be solved.
" Oh you who would fix it, don't bother with things like duplicating the Block
" rules and putting ``\*\@<!`` at the start of them; it makes it worse, as
" then you must deal with cases like ``/*/**/*/``. And don't try making it
" worse with ``\%(/\@<!\*\)\@<!``, either...

syn keyword ikuTodo contained TODO FIXME XXX NB NOTE
syn keyword ikuSafe contained UNSAFE SAFE

" Folding rules {{{2
" Trivial folding rules to begin with.
" TODO: use the AST to make really good folding
syn region ikuFoldBraces start="{" end="}" transparent fold

" Default highlighting {{{1
hi def link ikuDecNumber       ikuNumber
hi def link ikuHexNumber       ikuNumber
hi def link ikuOctNumber       ikuNumber
hi def link ikuBinNumber       ikuNumber
hi def link ikuIdentifierPrime ikuIdentifier
hi def link ikuTrait           ikuType

hi def link ikuMacroRepeatCount   ikuMacroRepeatDelimiters
hi def link ikuMacroRepeatDelimiters   Macro
hi def link ikuMacroVariable Define
hi def link ikuSigil         StorageClass
hi def link ikuEscape        Special
hi def link ikuEscapeUnicode ikuEscape
hi def link ikuEscapeError   Error
hi def link ikuStringContinuation Special
hi def link ikuString        String
hi def link ikuCharacterInvalid Error
hi def link ikuCharacterInvalidUnicode ikuCharacterInvalid
hi def link ikuCharacter     Character
hi def link ikuNumber        Number
hi def link ikuBoolean       Boolean
hi def link ikuEnum          ikuType
hi def link ikuEnumVariant   ikuConstant
hi def link ikuConstant      Constant
hi def link ikuSelf          Constant
hi def link ikuFloat         Float
hi def link ikuOperator      Operator
hi def link ikuKeyword       Keyword
hi def link ikuReservedKeyword Error
hi def link ikuConditional   Conditional
hi def link ikuIdentifier    Identifier
hi def link ikuCapsIdent     ikuIdentifier
hi def link ikuModPathInUse  ikuModPath
hi def link ikuModPath       Include
hi def link ikuModPathSep    Delimiter
hi def link ikuFunction      Function
hi def link ikuFuncName      Function
hi def link ikuFuncCall      Function
hi def link ikuCommentLine   Comment
hi def link ikuCommentLineDoc SpecialComment
hi def link ikuCommentBlock  ikuCommentLine
hi def link ikuCommentBlockDoc ikuCommentLineDoc
hi def link ikuAssert        PreCondit
hi def link ikuFail          PreCondit
hi def link ikuMacro         Macro
hi def link ikuQuestionmark  Macro
hi def link ikuType          Type
hi def link ikuUnsafe        ikuKeyword
hi def link ikuTodo          Todo
hi def link ikuAttribute     PreProc
hi def link ikuDeriving      PreProc
hi def link ikuStorage       StorageClass
hi def link ikuObsoleteStorage Error
hi def link ikuLifetime      Special
hi def link ikuInvalidBareKeyword Error
hi def link ikuExternCrate   ikuKeyword
hi def link ikuObsoleteExternMod Error
hi def link ikuBoxPlacementParens Delimiter
hi def link ikuBoxPlacementExpr ikuKeyword

" Other Suggestions:
" hi ikuAttribute ctermfg=cyan
" hi ikuDeriving ctermfg=cyan
" hi ikuAssert ctermfg=yellow
" hi ikuFail ctermfg=red
" hi ikuMacro ctermfg=magenta

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "iku"
