" NEO MONOKAI
" A mix between molokai and vim-molokai-tasty
" with support for some modern features and such
" and also CoC
hi clear
if exists("syntax_on")
    syntax reset
end

let g:colors_name="neomolokai"


" Set the column to be the same background color as Normal
if !exists('g:neomolokai_inv_column')
    let g:neomolokai_inv_column=0
endif

" Set the background color to be nothing thereby reusing the terminals color.
" Useful for transparency and terminal emulators using the same color scheme.
if !exists('g:neomolokai_no_bg')
    let g:neomolokai_no_bg=0
end


" Main colors
let s:yellow         = "#ffff87"
let s:purple         = "#af87ff"
let s:lime           = "#A4E400"
let s:cyan           = "#62D8F1"
let s:magenta        = "#F92672"
let s:orange         = "#FF9700"
let s:pumpkin        = "#ef5939"


let s:cyan_faded     = "#407F8C"
let s:magenta_faded  = "#95224C"
let s:orange_faded   = "#D17F06"

" Background colors
let s:white          = "#ffffff"
let s:light_grey     = "#bcbcbc"
let s:grey           = "#808080"
let s:dark_grey      = "#5f5f5f"
let s:darker_grey    = "#403D3D"
let s:light_charcoal = "#292929"
let s:charcoal       = "#1B1D1E" " The background color
let s:dark_charcoal  = "#26202b"
let s:columns_fg     = "#465457"

if g:neomolokai_no_bg
    let s:background = "NONE"
else
    let s:background = s:charcoal
end

if g:neomolokai_inv_column==1
    let s:columns_bg = s:background
else
    let s:columns_bg = "#232526" " default
endif

" Special colors
let s:danger         = "#ff005f"
let s:olive          = "#5f8700"
let s:dark_red       = "#870000"
let s:blood_red      = "#5f0000"
let s:green          = "#34c133"
let s:dark_green     = "#005f00"
let s:light_sea_blue = "#0087ff"
let s:sea_blue       = "#005faf"
let s:dark_sea_blue  = "#11243d"

" Styles
let s:none           = "NONE"
let s:bold = "bold"
let s:italic = "italic"
let s:underline = "underline"

let s:undercurl = "undercurl"



let s:empty = ""

" group, fg, bg, style, special
function! Highlight(group, fg,...)
    let thisfg = a:fg
    let thisbg = get(a:, 1, s:background)
    let style = get(a:, 2, s:none)
    let special = get(a:, 3, s:none)
    if (thisfg != s:empty)
        exec "hi " . a:group
                    \ . " guifg=" .   thisfg
                    \ . " guibg=" .   thisbg
                    \ . " gui="   .   style
                    \ . " guisp=" .   special
    else
        exec "hi " . a:group
                    \ . " guibg=" .   thisbg
                    \ . " gui="   .   style
                    \ . " guisp=" .   special
    end
endfunction

call Highlight("EndOfBuffer", s:charcoal, s:background)


" Terminal colors
let g:terminal_color_0 = s:dark_charcoal
let g:terminal_color_1 = s:magenta
let g:terminal_color_2 = s:lime
let g:terminal_color_3 = s:orange
let g:terminal_color_4 = s:purple
let g:terminal_color_5 = s:magenta
let g:terminal_color_6 = s:cyan
let g:terminal_color_7 = s:white

call Highlight("TermColor0", s:dark_charcoal, s:dark_charcoal)
call Highlight("TermColor1", s:magenta, s:magenta)
call Highlight("TermColor2", s:lime, s:lime)
call Highlight("TermColor3", s:orange, s:orange)
call Highlight("TermColor4", s:purple, s:purple)
call Highlight("TermColor5", s:magenta, s:magenta)
call Highlight("TermColor6", s:cyan, s:cyan)
call Highlight("TermColor7", s:white, s:white)

" The Basics
call Highlight("Normal", s:white, s:background, s:none)
call Highlight("Opaque", s:white, s:charcoal, s:none)
call Highlight("Conceal", s:none, s:none, s:none)

call Highlight("Cursor", s:charcoal, s:cyan, s:none)
call Highlight("CursorLine", s:none, s:dark_grey, s:none)

" Diff and stuff
call Highlight("DiffChange", s:empty, s:dark_sea_blue)
call Highlight("DiffText", s:empty, s:sea_blue)
call Highlight("DiffDelete", s:empty, s:dark_red)
call Highlight("DiffAdd", s:empty, s:dark_green)
" Gutter
call Highlight("DiffChangeGutter", s:light_sea_blue, s:columns_bg, s:none)
call Highlight("DiffDeleteGutter", s:magenta, s:columns_bg, s:none)
call Highlight("DiffAddGutter", s:green, s:columns_bg, s:none)


" Errors and Spelling
call Highlight("ErrorBg", s:danger, s:white, s:none)
call Highlight("Error", s:white, s:danger, s:none)
call Highlight("ErrorMsg", s:white, s:danger, s:none)
call Highlight("WarningMsg", s:danger, s:background, s:none)
call Highlight("SpellBad", s:empty, s:background, s:undercurl, s:danger)
call Highlight("SpellRare", s:empty, s:background, s:undercurl, s:white)
call Highlight("SpellCap", s:empty, s:background, s:undercurl, s:orange)
call Highlight("SpellLocal", s:empty, s:background, s:undercurl, s:cyan)

" Columns!
call Highlight("CursorColumn", s:none, s:light_charcoal)
call Highlight("ColorColumn", s:columns_fg, s:columns_bg)
call Highlight("LineNr", s:columns_fg, s:columns_bg)
call Highlight("SignColumn", s:grey, s:columns_bg)
call Highlight("FoldColumn", s:lime, s:columns_bg)

call Highlight("Folded", s:light_grey, s:light_charcoal)

call Highlight("CursorLineNR", s:yellow)


call Highlight("Visual", s:none, s:darker_grey, s:none)
call Highlight("VisualNOS", s:empty, s:light_charcoal, s:none)
call Highlight("TabLine", s:light_grey, s:dark_grey, s:underline)
call Highlight("Whitespace", s:dark_grey, s:none, s:none)

call Highlight("TabLineSel", s:none, s:background, s:bold)

call Highlight("Title", s:orange, s:none, s:bold)



call Highlight("SpecialKey", s:dark_grey, s:darker_grey, s:none)
call Highlight("IncSearch", s:none, s:light_sea_blue, s:bold)
call Highlight("Search", s:none, s:light_sea_blue, s:bold)

call Highlight("Question", s:cyan, s:none, s:none)


" ------------ SYNTAX -------------
" Constants and such
call Highlight("Constant", s:purple, s:none, s:none)
call Highlight("Boolean", s:purple, s:none, s:none)

call Highlight("Character", s:purple, s:none, s:none)
call Highlight("Float", s:purple, s:none, s:none)
call Highlight("Number", s:purple, s:none, s:none)
call Highlight("String", s:yellow, s:none, s:none)

call Highlight("Function", s:lime, s:none, s:none)
call Highlight("Identifier", s:orange, s:none, s:none)

" Prepoc
call Highlight("PreProc", s:lime)
call Highlight("Macro", s:purple)
call Highlight("Define", s:purple)
call Highlight("Include", s:lime)


" Statements
call Highlight("Statement", s:magenta, s:none, s:bold)
call Highlight("Conditional", s:magenta, s:none, s:bold)
call Highlight("Keyword", s:magenta)
call Highlight("Label", s:magenta, s:none, s:none)
call Highlight("Repeat", s:magenta)
call Highlight("Operator", s:magenta)
call Highlight("Exception", s:magenta, s:none, s:bold .",". s:italic)

" Types
call Highlight("Type", s:cyan, s:none, s:none)
call Highlight("StorageClass", s:cyan, s:none, s:italic)
call Highlight("Structure", s:cyan, s:none, s:none)

" Special
call Highlight("Special", s:cyan, s:italic)
call Highlight("Debug", s:magenta)

" Delimeters and such
call Highlight("Delimiter", s:grey, s:none, s:none)
call Highlight("MatchParen", s:darker_grey, s:orange, s:bold)

" Comments
call Highlight("Comment", s:grey, s:none, s:none)

" Misc.
call Highlight("Tag", s:purple, s:none, s:none)
call Highlight("Directory", s:lime, s:none, s:none)
call Highlight("Todo", s:yellow, s:dark_grey, s:bold)


" ----------- LAYOUT ----------
call Highlight("Underlined", s:none, s:none, s:underline)

" Layout
call Highlight("NonText", s:columns_fg, s:none, s:none)
call Highlight("VertSplit", s:grey, s:background, s:bold)
" call Highlight("StatusLine", s:white, '#232526', s:none)
" call Highlight("StatusLineNC", s:light_grey, '#232526', s:none)
call Highlight("StatusLine", s:white, 'NONE', s:none)
call Highlight("StatusLineNC", s:light_grey, 'NONE', s:none)

call Highlight("TabLineFill", s:none, '#232526', s:bold)
call Highlight("TabLineSel", s:cyan, s:columns_fg, s:bold)
call Highlight("TabLine", s:white, s:columns_bg, s:bold)

" Completion menus
call Highlight("Pmenu", s:orange, s:dark_charcoal, s:none)
call Highlight("PmenuSel", s:yellow, s:dark_grey, s:none)
call Highlight("PmenuSbar", s:none, s:darker_grey, s:none)
call Highlight("PmenuThumb", s:none, s:white, s:none)

call Highlight("WildMenu", s:cyan, s:columns_fg)


call Highlight("Floating", s:grey, s:charcoal)

" ----------- Barbar ----------
call Highlight('BufferCurrent',       s:white,          s:background)
call Highlight('BufferCurrentMod',    s:orange,         s:background)
call Highlight('BufferCurrentSign',   s:cyan,           s:background)
call Highlight('BufferCurrentTarget', s:dark_red,       s:background, 'bold')

call Highlight('BufferVisible',       s:grey,           s:light_charcoal)
call Highlight('BufferVisibleMod',    s:orange,         s:light_charcoal)
call Highlight('BufferVisibleSign',   s:darker_grey,    s:light_charcoal)
call Highlight('BufferVisibleTarget', s:dark_red,       s:light_charcoal, 'bold')

call Highlight('BufferInactive',       s:dark_grey,      s:light_charcoal)
call Highlight('BufferInactiveMod',    s:orange,         s:light_charcoal)
call Highlight('BufferInactiveSign',   s:darker_grey,    s:light_charcoal)
call Highlight('BufferInactiveTarget', s:dark_red,       s:light_charcoal, 'bold')

" -------------- COC -------------
call Highlight("CocErrorSign", s:magenta, s:columns_bg)
call Highlight("CocWarningSign", s:orange, s:columns_bg)
call Highlight("CocHintSign", s:cyan, s:columns_bg)
call Highlight("CocInfoSign", s:yellow, s:columns_bg)

call Highlight("CocErrorVirtualText", s:magenta_faded, s:none, s:italic)
call Highlight("CocWarningVirtualText", s:orange_faded, s:none, s:italic)
call Highlight("CocHintVirtualText", s:cyan_faded, s:none, s:italic)
call Highlight("CocInfoVirtualText", s:darker_grey, s:none, s:italic)

call Highlight("CocErrorHighlight", s:none, s:none, s:none, s:blood_red)
call Highlight("CocWarningHighlight", s:none, s:none, s:none, s:orange)

" call Highlight("CocFloating", s:light_sea_blue, s:dark_charcoal)
hi! link CocFloating Floating
call Highlight("CocCodeLens", s:sea_blue, s:background)

" Sneak
call Highlight("Sneak", s:none, s:purple)
call Highlight("SneakLabel", s:none, s:purple)
call Highlight("SneakScope", s:yellow, s:magenta)

" Rainbow Parentheses
let g:rainbow#blacklist = [s:white, s:charcoal]

" QuickUI
" call Highlight("QuickBG", s:light_grey, s:columns_bg)
call Highlight("QuickBG", s:light_grey, s:light_charcoal)
call Highlight("QuickSel", s:columns_bg, s:magenta, s:bold)
call Highlight("QuickKey", s:orange, s:none, s:bold)
call Highlight("QuickOff", s:darker_grey, s:none)
call Highlight("QuickHelp", s:sea_blue, s:none)

call Highlight("QuickScopePrimary", s:none, s:none, s:underline)
call Highlight("QuickScopeSecondary", s:none, s:none, s:italic .",". s:underline)

" Float Term
call Highlight("Floaterm", s:none, s:charcoal)
call Highlight("FloatermBorder", s:orange, s:charcoal)

" Indent Guides
call Highlight("IndentGuide", s:dark_grey, s:background)
let g:indentLine_color_gui = s:dark_grey

" Beacon
call Highlight("Beacon", s:white, s:cyan)

" Telescope
hi! link TelescopeSelection Cursorline
hi! link TelescopeSelectionCaret Keyword
hi TelescopeMultiSelection guifg=#928374 " multisections
hi! link TelescopeNormal   Normal

" Border highlight groups.
call Highlight("TelescopeBorder", s:purple, s:none)
call Highlight("TelescopePromptBorder", s:purple, s:none)
call Highlight("TelescopeResultsBorder", s:lime, s:none)
call Highlight("TelescopePreviewBorder", s:yellow, s:none)

" Used for highlighting characters that you match.
call Highlight("TelescopeMatching", s:cyan, s:none)

" Used for the prompt prefix
hi! link TelescopePromptPrefix Keyword


hi! link vimSet PreProc
hi! link vimIsCommand Statement
