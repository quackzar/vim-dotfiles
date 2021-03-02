

if v:version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syn case    ignore
syn match   ijvmComment         '//.*$' display contains=@Spell

syn match   ijvmSymbol          "[a-z_][a-z0-9_]*"
syn match   ijvmLabel           "[a-z_][a-z0-9_]*:"he=e-1

syn match   ijvmNumber          "\v(0x[0-9a-fA-F]+|\d+)"

syn match   ijvmMacro           "\.method"
syn match   ijvmMacro           "\.args"
syn match   ijvmMacro           "\.locals"
syn match   ijvmMacro           "\.define"

syn keyword ijvmFunction        bipush dup goto iadd iand ifeq iflt if_icmpeq iinc iload invokevirtual ior ireturn istore isub ldc_w nop pop swap



let b:current_syntax = 'ijvm'

hi def link ijvmStatement       Statement
hi def link ijvmKeyword         Keyword
hi def link ijvmFunction        Function
hi def link ijvmMacro           Macro
hi def link ijvmComment         Comment
hi def link ijvmLabel           Label
hi def link ijvmNumber          Number
hi def link ijvmSymbol          Identifier