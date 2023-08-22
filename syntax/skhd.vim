"
" skhd.vim for the SKHD hotkey daemon

if exists("b:current_syntax")
    finish
endif

syntax clear


syntax include @Shell syntax/sh.vim

setlocal commentstring=#\ %s
syn match skhdComment "#.*$" display

syn keyword skhdModifier fn alt lalt ralt shift lshift rshift cmd lcmd rcmd ctrl lctrl rctrl hyper meh
syn keyword skhdSpecialKey escape up down left right space tab return delete home end pageup pagedown insert sound_up sound_down mute play previos next rewind fast brightness_up brightness_down illumination_up illumination_down
syn match skhdFnKey "f\d\d"

syn match skhdMode "^\s*\a\+\s*\|^::\s*\a\+\s"
syn match skhdKey "\s\w\s\|0x\x\x"
" syn match skhdOperator "+\|-\|~\|->\|*\|@"
syn match skhdDelim "<\|\:\:\|\:\|\\\|;"
syn match skhdString "\".*\""



syn match skhdShell "^\s.*$" contains=@Shell
syn region skhdShellRegion start=":" end="$" keepend contains=@Shell
syn region skhdShellRegion start="\\$" end="$" keepend contains=@Shell

hi def link skhdModifier Keyword
hi def link skhdKey Constant
hi def link skhdSpecialKey Constant
hi def link skhdFnKey Constant

hi def link skhdOperator Operator
hi def link skhdDelim Delimiter
hi def link skhdComment Comment
hi def link skhdMode Type
hi def link skhdString String



let b:current_syntax = "skhd"
