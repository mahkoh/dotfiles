syn case match
syn keyword armasmTodo		NOTE TODO XXX contained
syn case ignore

syn region asmComment		start="/\*" end="\*/" contains=armasmTodo
syn region asmComment		start="//" end="$" keepend contains=armasmTodo
syn region asmComment		start=";" end="$" keepend contains=armasmTodo

syn match armasmIdentifier	"[a-z_$][a-z0-9_$]*"
syn match armasmLabel		"^[A-Z_$][A-Z0-9_$]*:"
syn region armasmLabel		start="||" end="||" oneline
syn region armasmLabel		start="|" end="|" oneline

syn region armasmASCII		start="'" end="'" skip="\\'" oneline
syn match armasmDecimal		"\d\+"
syn match armasmHexadecimal	"0[xX]\x\+"
syn match armasmHexadecimal	"&\x\+"
syn match armasmBinary		"2_[0-1]\+"
syn match armasmBase3		"3_[0-2]\+"
syn match armasmBase4		"4_[0-3]\+"
syn match armasmBase5		"5_[0-4]\+"
syn match armasmBase6		"6_[0-5]\+"
syn match armasmBase7		"7_[0-6]\+"
syn match armasmOctal		"8_[0-7]\o*"
syn match armasmBase9		"9_[0-8]\+"
syn match armasmFloat		"-\=[0-9]\+[eE]-\=[0-9]\+"
syn match armasmFloat		"-\=[0-9]*\.[0-9]\+\([eE]-\=[0-9]\+\)\="
syn match armasmBoolean		"{TRUE}"
syn match armasmBoolean		"{FALSE}"

syn match armasmBuiltIn		"{PC}"
syn match armasmBuiltIn		"{VAR}"
syn match armasmBuiltIn		"{TRUE}"
syn match armasmBuiltIn		"{FALSE}"
syn match armasmBuiltIn		"{OPT}"
syn match armasmBuiltIn		"{CONFIG}"
syn match armasmBuiltIn		"{ENDIAN}"
syn match armasmBuiltIn		"{CODESIZE}"
syn match armasmBuiltIn		"{CPU}"
syn match armasmBuiltIn		"{FPU}"
syn match armasmBuiltIn		"{ARCHITECTURE}"
syn match armasmBuiltIn		"{PCSTOREOFFSET}"
syn match armasmBuiltIn		"{ARMASM_VERSION}"
syn match armasmBuiltIn		"{INTER}"
syn match armasmBuiltIn		"{ROPI}"
syn match armasmBuiltIn		"{RWPI}"
syn match armasmBuiltIn		"{SWST}"
syn match armasmBuiltIn		"{NOSWST}"

syn region armasmString		start=+"+ end=+"+ oneline

syn match armasmOperator	":BASE:"
syn match armasmOperator	":INDEX:"
syn match armasmOperator	":LEN:"
syn match armasmOperator	":CHR:"
syn match armasmOperator	":STR:"
syn match armasmOperator	":NOT:"
syn match armasmOperator	":LNOT:"
syn match armasmOperator	":DEF:"
syn match armasmOperator	":SB_OFFSET_19_12:"
syn match armasmOperator	":SB_OFFSET_11_0:"
syn match armasmOperator	":MOD:"
syn match armasmOperator	":LEFT:"
syn match armasmOperator	":RIGHT:"
syn match armasmOperator	":CC:"
syn match armasmOperator	":ROL:"
syn match armasmOperator	":ROR:"
syn match armasmOperator	":SHL:"
syn match armasmOperator	":SHR:"
syn match armasmOperator	":AND:"
syn match armasmOperator	":OR:"
syn match armasmOperator	":EOR:"
syn match armasmOperator	":LAND:"
syn match armasmOperator	":LOR:"
syn match armasmOperator	":LEOR:"

syn keyword armasmRegister	x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15
syn keyword armasmRegister	x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28
syn keyword armasmRegister	x29 x30
syn keyword armasmRegister	ctr_el0 xzr

syn match armasmDirective "^\s*\.\w*"
syn match armasmDirective "\s\+\.\w*"

syn keyword armasmOpcode    abs adc adcs add addhn addhn2 addp adds addv adr adrp aesd
syn keyword armasmOpcode    aese aesimc aesmc and ands asr at b b.eq bfi bfxil bic bics
syn keyword armasmOpcode    bif bit bl blr br brk bsl cbnz cbz ccmn ccmp cinc cinv cls
syn keyword armasmOpcode    clz cmeq cmge cmgt cmhi cmhs cmle cmlt cmtst cneg cnt csel
syn keyword armasmOpcode    csinc csinv csneg dup eon eor ext extr fabd fabs facge facgt
syn keyword armasmOpcode    fadd faddp fccmp fcmeq fcmge fcmgt fcmle fcmlt fcmp fcsel
syn keyword armasmOpcode    fcvt fcvtas fcvtau fcvtl fcvtl2 fcvtms fcvtmu fcvtn fcvtn2
syn keyword armasmOpcode    fcvtns fcvtnu fcvtps fcvtpu fcvtxn fcvtxn2 fcvtzs fcvtzu
syn keyword armasmOpcode    fdiv fmadd fmax fmaxnm fmaxnmp fmaxnmv fmaxp fmaxv fmin
syn keyword armasmOpcode    fminnm fminnmp fminnmv fminp fminv fmla fmls fmov fmsub fmul
syn keyword armasmOpcode    fmulx fneg fnmadd fnmsub fnmul frecpe frecps frecpx frinta
syn keyword armasmOpcode    frinti frintm frintn frintp frintx frintz frsqrte frsqrts
syn keyword armasmOpcode    fsqrt fsub hlt ic ld1 ld1r ld2 ld2r ld3 ld3r ld4 ld4r ldar
syn keyword armasmOpcode    ldarb ldarh ldaxp ldaxr ldaxrb ldaxrh ldnp ldp ldpsw ldr
syn keyword armasmOpcode    ldrb ldrh ldrsb ldrsh ldrsw ldtr ldtrb ldtrh ldtrsb ldtrsh
syn keyword armasmOpcode    ldtrsw ldur ldurb ldurh ldursb ldursh ldursw ldxp ldxr ldxrb
syn keyword armasmOpcode    ldxrh lsl lsr madd mla mls mneg mov movi movk movn movz mrs
syn keyword armasmOpcode    msr msub mul mvn mvni neg orn orr pmul pmull pmull2 prfm
syn keyword armasmOpcode    prfum raddhn raddhn2 rbit ret rev rev16 rev32 rev64 ror
syn keyword armasmOpcode    rshrn rshrn2 rsubhn rsubhn2 saba sabal sabal2 sabd sabdl
syn keyword armasmOpcode    sabdl2 sadalp saddl saddl2 saddlp saddlv saddw saddw2 sbc
syn keyword armasmOpcode    sbcs sbfiz sbfx scvtf sdiv sha1c sha1h sha1m sha1p sha1su0
syn keyword armasmOpcode    sha1su1 sha256h sha256h2 sha256su0 sha256su1 shadd shl shll
syn keyword armasmOpcode    shll2 shrn shrn2 shsub sli smaddl smax smaxp smaxv smin
syn keyword armasmOpcode    sminp sminv smlal smlal2 smlsl smlsl2 smnegl smov smsubl
syn keyword armasmOpcode    smulh smull smull2 sqabs sqadd sqdmlal sqdmlal2 sqdmlsl
syn keyword armasmOpcode    sqdmlsl2 sqdmulh sqdmull sqdmull2 sqneg sqrdmulh sqrshl
syn keyword armasmOpcode    sqrshrn sqrshrn2 sqrshrun sqrshrun2 sqshl sqshlu sqshrn
syn keyword armasmOpcode    sqshrn2 sqshrun sqshrun2 sqsub sqxtn sqxtn2 sqxtun sqxtun2
syn keyword armasmOpcode    srhadd sri srshl srshr srsra sshl sshll sshll2 sshr ssra
syn keyword armasmOpcode    ssubl ssubl2 ssubw ssubw2 st1 st2 st3 st4 stlr stlrb stlrh
syn keyword armasmOpcode    stlxp stlxr stlxrb stlxrh stnp stp str strb strh sttr sttrb
syn keyword armasmOpcode    sttrh stur sturb sturh stxp stxr stxrb stxrh sub subhn
syn keyword armasmOpcode    subhn2 subs suqadd sxtb sxth sxtw sys sysl tbl tbnz tbx tbz
syn keyword armasmOpcode    tlbi trn1 trn2 uaba uabal uabal2 uabd uabdl uabdl2 uadalp
syn keyword armasmOpcode    uaddl uaddl2 uaddlp uaddlv uaddw uaddw2 ubfiz ubfx ucvtf
syn keyword armasmOpcode    udiv uhadd uhsub umaddl umax umaxp umaxv umin uminp uminv
syn keyword armasmOpcode    umlal umlal2 umlsl umlsl2 umnegl umov umsubl umulh umull
syn keyword armasmOpcode    umull2 uqadd uqrshl uqrshrn uqrshrn2 uqshl uqshrn uqshrn2
syn keyword armasmOpcode    uqsub uqxtn uqxtn2 urecpe urhadd urshl urshr ursqrte ursra
syn keyword armasmOpcode    ushl ushll ushll2 ushr usqadd usra usubl usubl2 usubw usubw2
syn keyword armasmOpcode    uxtb uxth uzp1 uzp2 xtn xtn2 zip1 zip2 ubfm cmp dc b\.lo

hi link armasmTodo        Todo
hi link armasmComment     Comment
hi link armasmDirective   Statement
hi link armasmString      String
hi link armasmRegister    Structure
hi link armasmASCII       Character
hi link armasmBinary      Number
hi link armasmDecimal     Number
hi link armasmHexadecimal Number
hi link armasmOctal       Number
hi link armasmBase3       Number
hi link armasmBase4       Number
hi link armasmBase5       Number
hi link armasmBase6       Number
hi link armasmBase7       Number
hi link armasmBase9       Number
hi link armasmFloat       Float
hi link armasmBoolean     Boolean
hi link armasmBuiltIn     Constant
hi link armasmIdentifier  Normal
hi link armasmLabel       Label
hi link armasmOpcode      Keyword
hi link armasmOperator    Operator

let b:current_syntax = "aarch64asm"

" vim: ts=8
