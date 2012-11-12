" Version 1

scriptencoding utf-8
let b:current_syntax="tex"
syn sync fromstart

syn  region  texGenRegion   matchgroup=Delimiter           start="{"                  end="}"   transparent
syn  region  texGenRegion   matchgroup=Delimiter           start="\["                 end="\]"  transparent
syn  region  texGenSubName  matchgroup=texGenSubDelimiter  start='\\\(begin\|end\){'  end='}'

syn match texGenStatement '\\\a\+'

syn  match  texClass      "\\documentclass"    nextgroup=texOption,texArgument
syn  match  texStatement  "\\usepackage"       nextgroup=texOption,texArgument
syn  match  texStatement  "\\newtheorem\*\?"   nextgroup=texOption,texHiArgument
"syn  match  texStatement  "\\begin{minipage}"
syn  region  texOption      matchgroup=Delimiter  start="\["  end="\]"  contained  nextgroup=texArgument
syn  region  texArgument    matchgroup=Delimiter  start="{"   end="}"   contained  nextgroup=texOption,texArgument
syn  region  texHiArgument  matchgroup=Delimiter  start="{"   end="}"   contained  nextgroup=texOption,texArgument

syn region texMakeAt start="\\makeatletter" end="\\makeatother"
syn match  texComment "%.*$"
" Theorems {{{1
syn  region  texThm  matchgroup=texThmDelimiter  start='\\begin{thm}'    end='\\end{thm}'    transparent
syn  region  texThm  matchgroup=texThmDelimiter  start='\\begin{dfn}'    end='\\end{dfn}'    transparent
syn  region  texThm  matchgroup=texThmDelimiter  start='\\begin{lem}'    end='\\end{lem}'    transparent
syn  region  texThm  matchgroup=texThmDelimiter  start='\\begin{kor}'    end='\\end{kor}'    transparent
syn  region  texThm  matchgroup=texThmDelimiter  start='\\begin{cor}'    end='\\end{cor}'    transparent
syn  region  texThm  matchgroup=texThmDelimiter  start='\\begin{bem}'    end='\\end{bem}'    transparent
syn  region  texThm  matchgroup=texThmDelimiter  start='\\begin{rem}'    end='\\end{rem}'    transparent
syn  region  texThm  matchgroup=texThmDelimiter  start='\\begin{proof}'  end='\\end{proof}'  transparent
" Document Structure {{{1
syn  match  texDocumentStructure  "\\begin{document}"
syn  match  texDocumentStructure  "\\end{document}"
syn  match  texDocumentStructure  "\\part{.*}"
syn  match  texDocumentStructure  "\\section\*\?{.*}"
syn  match  texDocumentStructure  "\\subsection\*\?{.*}"
syn  match  texDocumentStructure  "\\subsubsection\*\?{.*}"
syn  match  texDocumentStructure  "\\paragraph\*\?{.*}"
" NewCommand {{{1
syn  match   texNewCmd        "\\\(re\)\?newcommand"                      nextgroup=texNewCmdName
syn  region  texNewCmdName    matchgroup=Delimiter  start="{"   end="}"   nextgroup=texNewCmdArgNum,texNewCmdValue  contained
syn  region  texNewCmdArgNum  matchgroup=Delimiter  start="\["  end="\]"  nextgroup=texNewCmdValue                  contained
syn  region  texNewCmdValue   matchgroup=Delimiter  start="{"   end="}$"                                            contained
" DeclareMathOperator {{{1
syn  match   texDecMathOp       "\\DeclareMathOperator"                   nextgroup=texDecMathOpName
syn  region  texDecMathOpName   matchgroup=Delimiter  start="{"  end="}"  nextgroup=texDecMathOpValue  contained
syn  region  texDecMathOpValue  matchgroup=Delimiter  start="{"  end="}"                               contained
" Math {{{1
" Math Region {{{2
syn  region  texMathRegion  matchgroup=texInlineMathDelimiter  start="\$"                  end="\$"                contains=@texMathGroup skip='\\\$'
syn  region  texMathRegion  matchgroup=texMathDelimiter        start="\\\["                end="\\\]"              contains=@texMathGroup
syn  region  texMathRegion  matchgroup=texMathDelimiter        start="\\begin{equation}"   end="\\end{equation}"   contains=@texMathGroup
syn  region  texMathRegion  matchgroup=texMathDelimiter        start="\\begin{align}"      end="\\end{align}"      contains=@texMathGroup
syn  region  texMathRegion  matchgroup=texMathDelimiter        start="\\begin{align\*}"    end="\\end{align\*}"    contains=@texMathGroup
syn  region  texMathRegion  matchgroup=texMathDelimiter        start="\\begin{alignat}"    end="\\end{alignat}"    contains=@texMathGroup
syn  region  texMathRegion  matchgroup=texMathDelimiter        start="\\begin{alignat\*}"  end="\\end{alignat\*}"  contains=@texMathGroup

syn cluster texMathGroup contains=texMathIgnoredStatement,texMathEquality,texMathGreek,texMathSymbols,texMathOperator,texMathNumber,texMathConstant,texRef,texMathSubSupScript,texMathParantheses,texMathModifier,texMathInlineText,texMathGenSub,texMathStructureParantheses,texMathFont,texMathLineBreak
" Ignored Command {{{2
" We can't match nested statements.
syn match texMathIgnoredStatement '\\\a\+\({[^{}]*}\)*' contained
" Linebreak {{{2
syn match texMathLineBreak '\\\\' contained
" References {{{2
syn match texRef '\\\(label\|ref\|nonumber\|tag\|cite\)' nextgroup=texRefArgument
syn region texRefArgument matchgroup=Delimiter start='{' end='}' contained
" Parantheses {{{2
syn match texMathParantheses contained '\(\\[{}]\|[()|]\)'
" Sturcture Parantheses {{{2
syn match texMathStructureParantheses contained '[{}]'
" NoArgumentSubregion {{{2
syn  match   texMathGenSub      nextgroup=texMathGenSubName  contained  '\\\(begin\|end\)'
syn  region  texMathGenSubName  nextgroup=texMathGenSubName  contained  matchgroup=texMathGenSubNameDelimiter  start='{'  end='}'
" InlineText {{{2
syn region texMathInlineText matchgroup=texMathInlineTextDelimiter start='\\text\(sl\|rm\|it\|bf\)\?{' skip='\\}' end='}' contains=TOP
" Sub/Supscript {{{2
syn match texMathSubSupScript contained '[\^_]'
" Equality {{{2
syn match texMathEquality contained ':\?\(=\|\\leq\|\\geq\|\\neq\|\\to\|<\|>\)'
" Greek {{{2
syn match texMathGreek contained '\\\(
            \alpha\|
            \beta\|
            \chi\|
            \delta\|
            \Delta\|
            \epsilon\|
            \gamma\|
            \Gamma\|
            \kappa\|
            \lambda\|
            \Lambda\|
            \mu\|
            \nabla\|
            \nu\|
            \pi\|
            \tau\|
            \theta\|
            \Theta\|
            \omega\|
            \Omega\|
            \phi\|
            \psi\|
            \sigma\|
            \varepsilon\|
            \varphi\|
            \varpsi\|
            \xi\|
            \zeta
            \\)'
" Modifier {{{2
syn match texMathModifier contained '\\\(left\|right\|qquad\|quad\)'
" Symbols {{{2
syn match texMathSymbols contained '\\\(
            \emptyset\|
            \bvo\|
            \pm\|
            \R
            \\)'
" Numbers {{{2
syn match texMathNumber contained "\d"
" Constants {{{2
syn match texMathConstant contained "\\infty"
" Operators {{{2
syn match texMathOperator contained '\\\(
            \infty
            \\)\@!\(
            \xrightarrow\|
            \xra\|
            \wedge\|
            \weaks\|
            \weak\|
            \vee\|
            \uparrow\|
            \top\|
            \times\|
            \tilde\|
            \supset\|
            \supp\|
            \sup\|
            \sum\|
            \subset\|
            \subset\|
            \strict\|
            \sqrt\|
            \simeq\|
            \sign\|
            \setminus\|
            \Rightarrow\|
            \prod\|
            \po\|
            \perp\|
            \partial\|
            \overline\|
            \otimes\|
            \op\|
            \norm\|
            \mapsto\|
            \Lr\|
            \limsup\|
            \liminf\|
            \lim\|
            \Leftrightarrow\|
            \ldots\|
            \ldot\|
            \lb\|
            \intertext\|
            \int\|
            \inf\|
            \in\|
            \hm\|
            \hat\|
            \frac\|
            \forall\|
            \fint\|
            \fa\|
            \f\|
            \exists\|
            \exact\|
            \es\|
            \downarrow\|
            \div\|
            \dist\|
            \det\|
            \curl\|
            \cup\|
            \cong\|
            \colon\|
            \cdots\|
            \cdot\|
            \cap\|
            \bigcup\|
            \bigcap\|
            \big
            \\)'
" Font {{{2
syn match texMathFont contained '\\\(
            \mathcal\|
            \mathrm\|
            \mathbf\|
            \mathbb
            \\)'
" Highlight {{{1
hi  link  texClass                     texStatement
hi  link  texComment                   texLowVisibility
hi  link  texDecMathOpName             texHiArgument
hi  link  texDecMathOp                 texStatement
hi  link  texDecMathOpValue            texArgument
hi  link  texGenStatement              texStatement
hi  link  texHiArgument                texHighVisibility
hi  link  texInlineMathDelimiter       Delimiter
hi  link  texMakeAt                    texLowVisibility
hi  link  texMathGenSubNameDelimiter   Delimiter
hi  link  texMathGenSub                texStatement
hi  link  texMathIgnoredStatement      texLowVisibility
hi  link  texMathInlineTextDelimiter   Delimiter
hi  link  texMathOperator              texStatement
hi  link  texMathStructureParantheses  Delimiter
hi  link  texNewCmdArgNum              texOption
hi  link  texNewCmdName                texHiArgument
hi  link  texNewCmd                    texStatement
hi  link  texNewCmdValue               texLowVisibility
hi  link  texRef                       texLowVisibility
hi  link  texMathLineBreak             SpecialChar
