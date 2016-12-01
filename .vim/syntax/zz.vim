" Vim syntax file
" Language:     zz

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   zzConditional match if else
syn keyword   zzOperator    as

syn match     zzAssert      "\<assert\(\w\)*!" contained
syn match     zzFail        "\<fail\(\w\)*!" contained
syn keyword   zzKeyword     break
syn keyword   zzKeyword     box nextgroup=zzBoxPlacement skipwhite skipempty
syn keyword   zzKeyword     continue library
syn keyword   zzKeyword     fn nextgroup=zzFuncName skipwhite skipempty
syn keyword   zzKeyword     for in if impl let
syn keyword   zzKeyword     loop proc pub
syn keyword   zzKeyword     return super
syn keyword   zzKeyword     virtual where while
syn keyword   zzUnsafe      unsafe
syn keyword   zzKeyword     use nextgroup=zzModPath,zzModPathInUse skipwhite skipempty
" FIXME: Scoped impl's name is also fallen in this category
syn keyword   zzKeyword     mod trait struct enum type nextgroup=zzIdentifier skipwhite skipempty
syn keyword   zzStorage     move mut ref static const

syn match     zzIdentifier  contains=zzIdentifierPrime "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match     zzFuncName    "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained

syn region    zzBoxPlacement matchgroup=zzBoxPlacementParens start="(" end=")" contains=TOP contained
syn keyword   zzBoxPlacementExpr GC containedin=zzBoxPlacement
" Ideally we'd have syntax rules set up to match arbitrary expressions. Since
" we don't, we'll just define temporary contained rules to handle balancing
" delimiters.
syn region    zzBoxPlacementBalance start="(" end=")" containedin=zzBoxPlacement transparent
syn region    zzBoxPlacementBalance start="\[" end="\]" containedin=zzBoxPlacement transparent
" {} are handled by zzFoldBraces

syn region zzMacroRepeat matchgroup=zzMacroRepeatDelimiters start="$(" end=")" contains=TOP nextgroup=zzMacroRepeatCount
syn match zzMacroRepeatCount ".\?[*+]" contained
syn match zzMacroVariable "$\w\+"

" Reserved (but not yet used) keywords {{{2
syn keyword   zzReservedKeyword alignof be do offsetof priv pure sizeof typeof unsized yield

" Built-in types {{{2
syn keyword   zzType        isize usize char bool d8 u8 u16 u32 u64 f32
syn keyword   zzType        f64 i8 i16 i32 i64 str Self

syn keyword zzSelf self
syn keyword zzBoolean true false

" Other syntax {{{2

" If foo::bar changes to foo.bar, change this ("::" to "\.").
" If foo::bar changes to Foo::bar, change this (first "\w" to "\u").
syn match     zzModPath     "\w\(\w\)*::[^<]"he=e-3,me=e-3
syn match     zzModPathInUse "\w\(\w\)*" contained " only for 'use path;'
syn match     zzModPathSep  "::"
" zzModPathInUse is split out from zzModPath so that :syn-include can get the group list right.

syn match     zzFuncCall    "\w\(\w\)*("he=e-1,me=e-1
syn match     zzFuncCall    "\w\(\w\)*::<"he=e-3,me=e-3 " foo::<T>();

" This is merely a convention; note also the use of [A-Z], restricting it to
" latin identifiers rather than the full Unicode uppercase. I have not used
" [:upper:] as it depends upon 'noignorecase'
"syn match     zzCapsIdent    display "[A-Z]\w\(\w\)*"

syn match     zzOperator     display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"
" This one isn't *quite* right, as we could have binary-& with a reference
syn match     zzSigil        display /&\s\+[&~@*][^)= \t\r\n]/he=e-1,me=e-1
syn match     zzSigil        display /[&~@*][^)= \t\r\n]/he=e-1,me=e-1
" This isn't actually correct; a closure with no arguments can be `|| { }`.
" Last, because the & in && isn't a sigil
syn match     zzOperator     display "&&\|||"

syn match     zzMacro       '\w\(\w\)*!' contains=zzAssert,zzFail
syn match     zzMacro       '#\w\(\w\)*' contains=zzAssert,zzFail
syn match     zzQuestionmark '?'

syn match     zzEscapeError   display contained /\\./
syn match     zzEscape        display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     zzEscapeUnicode display contained /\\\(u\x\{4}\|U\x\{8}\)/
syn match     zzStringContinuation display contained /\\\n\s*/
syn region    zzString      start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=zzEscape,zzEscapeError,zzStringContinuation
syn region    zzString      start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=zzEscape,zzEscapeUnicode,zzEscapeError,zzStringContinuation,@Spell
syn region    zzString      start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

syn region    zzAttribute   start="#!\?\[" end="\]" contains=zzString,zzDeriving
syn region    zzDeriving    start="derive(" end=")" contained contains=zzTrait

" Number literals
syn match     zzDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\)\=\)\="
syn match     zzHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\)\=\)\="
syn match     zzOctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\)\=\)\="
syn match     zzBinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\)\=\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access.
" (This must go first so the others take precedence.)
syn match     zzFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     zzFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     zzFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     zzFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

" For the benefit of delimitMate
syn region zzLifetimeCandidate display start=/&'\%(\([^'\\]\|\\\(['nrt0\\\"]\|x\x\{2}\|u\x\{4}\|U\x\{8}\)\)'\)\@!/ end=/[[:cntrl:][:space:][:punct:]]\@=\|$/ contains=zzSigil,zzLifetime
syn region zzGenericRegion display start=/<\%('\|[^[cntrl:][:space:][:punct:]]\)\@=')\S\@=/ end=/>/ contains=zzGenericLifetimeCandidate
syn region zzGenericLifetimeCandidate display start=/\%(<\|,\s*\)\@<='/ end=/[[:cntrl:][:space:][:punct:]]\@=\|$/ contains=zzSigil,zzLifetime

"zzLifetime must appear before zzCharacter, or chars will get the lifetime highlighting
syn match     zzLifetime    display "\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*"
syn match   zzCharacterInvalid   display contained /b\?'\zs[\n\r\t']\ze'/
" The groups negated here add up to 0-255 but nothing else (they do not seem to go beyond ASCII).
syn match   zzCharacterInvalidUnicode   display contained /b'\zs[^[:cntrl:][:graph:][:alnum:][:space:]]\ze'/
syn match   zzCharacter   /b'\([^\\]\|\\\(.\|x\x\{2}\)\)'/ contains=zzEscape,zzEscapeError,zzCharacterInvalid,zzCharacterInvalidUnicode
syn match   zzCharacter   /'\([^\\]\|\\\(.\|x\x\{2}\|u\x\{4}\|U\x\{8}\)\)'/ contains=zzEscape,zzEscapeUnicode,zzEscapeError,zzCharacterInvalid

syn region zzCommentLine                                        start="//"                      end="$"   contains=zzTodo,zzSafe,@Spell
syn region zzCommentLineDoc                                     start="//\%(//\@!\|!\)"         end="$"   contains=zzTodo,zzSafe,@Spell
syn region zzCommentBlock    matchgroup=zzCommentBlock        start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=zzTodo,zzSafe,zzCommentBlockNest,@Spell
syn region zzCommentBlockDoc matchgroup=zzCommentBlockDoc     start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=zzTodo,zzSafe,zzCommentBlockDocNest,@Spell
syn region zzCommentBlockNest matchgroup=zzCommentBlock       start="/\*"                     end="\*/" contains=zzTodo,zzSafe,zzCommentBlockNest,@Spell contained transparent
syn region zzCommentBlockDocNest matchgroup=zzCommentBlockDoc start="/\*"                     end="\*/" contains=zzTodo,zzSafe,zzCommentBlockDocNest,@Spell contained transparent
" FIXME: this is a really ugly and not fully correct implementation. Most
" importantly, a case like ``/* */*`` should have the final ``*`` not being in
" a comment, but in practice at present it leaves comments open two levels
" deep. But as long as you stay away from that particular case, I *believe*
" the highlighting is correct. Due to the way Vim's syntax engine works
" (greedy for start matches, unlike zz's tokeniser which is searching for
" the earliest-starting match, start or end), I believe this cannot be solved.
" Oh you who would fix it, don't bother with things like duplicating the Block
" rules and putting ``\*\@<!`` at the start of them; it makes it worse, as
" then you must deal with cases like ``/*/**/*/``. And don't try making it
" worse with ``\%(/\@<!\*\)\@<!``, either...

syn keyword zzTodo contained TODO FIXME XXX NB NOTE
syn keyword zzSafe contained UNSAFE SAFE

" Folding rules {{{2
" Trivial folding rules to begin with.
" TODO: use the AST to make really good folding
syn region zzFoldBraces start="{" end="}" transparent fold

" Default highlighting {{{1
hi def link zzDecNumber       zzNumber
hi def link zzHexNumber       zzNumber
hi def link zzOctNumber       zzNumber
hi def link zzBinNumber       zzNumber
hi def link zzIdentifierPrime zzIdentifier
hi def link zzTrait           zzType

hi def link zzMacroRepeatCount   zzMacroRepeatDelimiters
hi def link zzMacroRepeatDelimiters   Macro
hi def link zzMacroVariable Define
hi def link zzSigil         StorageClass
hi def link zzEscape        Special
hi def link zzEscapeUnicode zzEscape
hi def link zzEscapeError   Error
hi def link zzStringContinuation Special
hi def link zzString        String
hi def link zzCharacterInvalid Error
hi def link zzCharacterInvalidUnicode zzCharacterInvalid
hi def link zzCharacter     Character
hi def link zzNumber        Number
hi def link zzBoolean       Boolean
hi def link zzEnum          zzType
hi def link zzEnumVariant   zzConstant
hi def link zzConstant      Constant
hi def link zzSelf          Constant
hi def link zzFloat         Float
hi def link zzOperator      Operator
hi def link zzKeyword       Keyword
hi def link zzReservedKeyword Error
hi def link zzConditional   Conditional
hi def link zzIdentifier    Identifier
hi def link zzCapsIdent     zzIdentifier
hi def link zzModPathInUse  zzModPath
hi def link zzModPath       Include
hi def link zzModPathSep    Delimiter
hi def link zzFunction      Function
hi def link zzFuncName      Function
hi def link zzFuncCall      Function
hi def link zzCommentLine   Comment
hi def link zzCommentLineDoc SpecialComment
hi def link zzCommentBlock  zzCommentLine
hi def link zzCommentBlockDoc zzCommentLineDoc
hi def link zzAssert        PreCondit
hi def link zzFail          PreCondit
hi def link zzMacro         Macro
hi def link zzQuestionmark  Macro
hi def link zzType          Type
hi def link zzUnsafe        zzKeyword
hi def link zzTodo          Todo
hi def link zzAttribute     PreProc
hi def link zzDeriving      PreProc
hi def link zzStorage       StorageClass
hi def link zzObsoleteStorage Error
hi def link zzLifetime      Special
hi def link zzInvalidBareKeyword Error
hi def link zzExternCrate   zzKeyword
hi def link zzObsoleteExternMod Error
hi def link zzBoxPlacementParens Delimiter
hi def link zzBoxPlacementExpr zzKeyword

" Other Suggestions:
" hi zzAttribute ctermfg=cyan
" hi zzDeriving ctermfg=cyan
" hi zzAssert ctermfg=yellow
" hi zzFail ctermfg=red
" hi zzMacro ctermfg=magenta

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "zz"
