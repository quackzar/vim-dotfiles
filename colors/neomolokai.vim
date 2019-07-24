" NEO MONOKAI
" A mix between molokai and vim-molokai-tasty

hi clear
if exists("syntax_on")
  syntax reset
end

let g:colors_name="neomolokai"

" Main colors
let s:yellow = { "cterm": 228, "gui": "#ffff87" }
let s:purple = { "cterm": 141, "gui": "#af87ff" }
let s:lime = { "cterm": 148, "gui": "#A4E400" }
let s:cyan = { "cterm": 81, "gui": "#62D8F1" }
let s:magenta = { "cterm": 197, "gui": "#F92672" }
let s:orange = { "cterm": 208, "gui": "#FF9700" }

" Background colors
let s:white = { "cterm": 231, "gui": "#ffffff" }
let s:light_grey = { "cterm": 250, "gui": "#bcbcbc" }
let s:grey = { "cterm": 245, "gui": "#808080" }
let s:dark_grey = { "cterm": 59, "gui": "#5f5f5f" }
let s:darker_grey = { "cterm": 238, "gui": "#403D3D" }
let s:light_charcoal = { "cterm": 238, "gui": "#292929" }
let s:charcoal = { "cterm": 235, "gui": "#1B1D1E" }
let s:dark_charcoal = { "cterm": 235, "gui": "#0E0E0E" }

let s:columns_bg = { "cterm": 0, "gui": "#232526"}
let s:columns_fg = { "cterm": 0, "gui": "#465457"}


" Special colors
let s:danger = { "cterm": 197, "gui": "#ff005f" }
let s:olive = { "cterm": 64, "gui": "#5f8700" }
let s:dark_red = { "cterm": 88, "gui": "#870000" }
let s:blood_red = { "cterm": 52, "gui": "#5f0000" }
let s:dark_green = { "cterm": 22, "gui": "#005f00" }
let s:light_sea_blue = { "cterm": 33, "gui": "#0087ff" }
let s:sea_blue = { "cterm": 25, "gui": "#005faf" }

" Styles
let s:none = { "cterm": "NONE", "gui": "NONE" }
let s:bold = { "cterm": "bold", "gui": "bold" }
let s:italic = { "cterm": "italic", "gui": "italic" }
let s:underline = { "cterm": "underline", "gui": "underline" }
let s:bold_underline = { "cterm": "bold,underline", "gui": "bold,underline" }
let s:bold_italic = { "cterm": "italic,bold", "gui": "italic,bold"}


let s:undercurl = { "cterm": "undercurl", "gui": "undercurl"}


let s:empty = {}

" group, fg, bg, style, special
function! Highlight(group, fg,...)
  let thisfg = a:fg
  let thisbg = get(a:, 1, s:charcoal)
  let style = get(a:, 2, s:none)
  let special = get(a:, 3, s:none)
  if (thisfg != s:empty)
    exec "hi " . a:group
          \ . " ctermfg=" . thisfg["cterm"]
          \ . " ctermbg=" . thisbg["cterm"]
          \ . " cterm=" .   style["cterm"]
          \ . " guifg=" .   thisfg["gui"]
          \ . " guibg=" .   thisbg["gui"]
          \ . " gui="   .   style["gui"]
          \ . " guisp=" .   special["gui"]
  else
    exec "hi " . a:group
          \ . " ctermbg=" . thisbg["cterm"]
          \ . " cterm=" .   style["cterm"]
          \ . " guibg=" .   thisbg["gui"]
          \ . " gui="   .   style["gui"]
          \ . " guisp=" .   special["gui"]
  end
endfunction


" Terminal colors
let g:terminal_color_0 = s:dark_charcoal["gui"]
let g:terminal_color_1 = s:magenta["gui"]
let g:terminal_color_2 = s:lime["gui"]
let g:terminal_color_3 = s:orange["gui"]
let g:terminal_color_4 = s:purple["gui"]
let g:terminal_color_5 = s:magenta["gui"]
let g:terminal_color_6 = s:cyan["gui"]
let g:terminal_color_7 = s:white["gui"]
call Highlight("TermColor0", s:dark_charcoal, s:dark_charcoal)
call Highlight("TermColor1", s:magenta, s:magenta)
call Highlight("TermColor2", s:lime, s:lime)
call Highlight("TermColor3", s:orange, s:orange)
call Highlight("TermColor4", s:purple, s:purple)
call Highlight("TermColor5", s:magenta, s:magenta)
call Highlight("TermColor6", s:cyan, s:cyan)
call Highlight("TermColor7", s:white, s:white)

" The Basics
call Highlight("Normal", s:white, s:charcoal, s:none)
call Highlight("Conceal", s:none, s:none, s:none)

call Highlight("Cursor", s:charcoal, s:cyan, s:none)
call Highlight("CursorLine", s:none, s:dark_grey, s:none)

" Diff and stuff
call Highlight("DiffChange", s:sea_blue, s:columns_bg, s:none)
call Highlight("DiffText", s:light_sea_blue, s:columns_bg, s:none)
call Highlight("DiffDelete", s:dark_red, s:columns_bg, s:none)
call Highlight("DiffAdd", s:dark_green, s:columns_bg, s:none)

" Errors and Spelling
call Highlight("ErrorBg", s:danger, s:white, s:none)
call Highlight("Error", s:white, s:danger, s:none)
call Highlight("ErrorMsg", s:white, s:danger, s:none)
call Highlight("WarningMsg", s:white, s:danger, s:none)
call Highlight("SpellBad", s:empty, s:charcoal, s:undercurl, s:danger)
call Highlight("SpellRare", s:empty, s:charcoal, s:undercurl, s:white)
call Highlight("SpellCap", s:empty, s:charcoal, s:undercurl, s:orange)
call Highlight("SpellLocal", s:charcoal, s:charcoal, s:undercurl, s:cyan)

" Columns!
call Highlight("CursorColumn", s:none, s:light_charcoal)
call Highlight("ColorColumn", s:columns_fg, s:columns_bg)
call Highlight("LineNr", s:columns_fg, s:columns_bg)
call Highlight("SignColumn", s:grey, s:columns_bg)
call Highlight("CursorLineNR", s:yellow)

call Highlight("Type", s:cyan, s:none, s:none)

call Highlight("Visual", s:none, s:darker_grey, s:none)
call Highlight("VisualNOS", s:empty, s:light_charcoal, s:none)
call Highlight("TabLine", s:light_grey, s:dark_grey, s:underline)
call Highlight("Whitespace", s:dark_grey, s:none, s:none)

call Highlight("TabLineSel", s:none, s:charcoal, s:bold)


" Delimeters and such
call Highlight("Delimiter", s:grey, s:none, s:none)
call Highlight("MatchParen", s:darker_grey, s:orange, s:bold)

call Highlight("Exception", s:magenta, s:none, s:bold_italic)
call Highlight("Include", s:magenta, s:none, s:none)

call Highlight("Title", s:orange, s:none, s:bold)
call Highlight("Special", s:cyan, s:none, s:italic)
call Highlight("Define", s:magenta)
call Highlight("Debug", s:magenta)
call Highlight("Keyword", s:magenta)
call Highlight("PreProc", s:lime)
call Highlight("Statement", s:magenta, s:none, s:bold)
call Highlight("Repeat", s:magenta)
call Highlight("Operator", s:magenta)
call Highlight("Macro", s:purple)

call Highlight("SpecialKey", s:dark_grey, s:darker_grey, s:none)
call Highlight("IncSearch", s:white, s:purple, s:bold_underline)
call Highlight("Search", s:white, s:purple, s:bold_underline)

call Highlight("Identifier", s:orange, s:none, s:none)
call Highlight("Question", s:cyan, s:none, s:none)
call Highlight("StorageClass", s:cyan, s:none, s:italic)
call Highlight("Structure", s:cyan, s:none, s:none)

call Highlight("Function", s:lime, s:none, s:none)


" Constants and such
call Highlight("Constant", s:purple, s:none, s:none)
call Highlight("Directory", s:lime, s:none, s:none)
call Highlight("Tag", s:purple, s:none, s:none)
call Highlight("Boolean", s:purple, s:none, s:none)
call Highlight("Character", s:purple, s:none, s:none)
call Highlight("Float", s:purple, s:none, s:none)
call Highlight("Number", s:purple, s:none, s:none)

call Highlight("Folded", s:grey, s:charcoal, s:none)
call Highlight("Comment", s:grey, s:none, s:italic)

call Highlight("Label", s:yellow, s:none, s:none)
call Highlight("String", s:yellow, s:none, s:none)

call Highlight("Todo", s:yellow, s:dark_grey, s:bold)
call Highlight("Underlined", s:none, s:none, s:underline)

" Layout
call Highlight("NonText", s:columns_fg, s:none, s:none)
call Highlight("TabLineFill", s:none, s:darker_grey, s:none)
call Highlight("VertSplit", s:grey, s:charcoal, s:bold)
call Highlight("StatusLine", s:white, s:columns_fg, s:none)
call Highlight("StatusLineNC", s:light_grey, s:columns_fg, s:none)


" Completion menus
call Highlight("Pmenu", s:cyan, s:dark_charcoal, s:none)
call Highlight("PmenuSel", s:yellow, s:dark_grey, s:none)
call Highlight("PmenuSbar", s:none, s:darker_grey, s:none)
call Highlight("PmenuThumb", s:none, s:white, s:none)

call Highlight("WildMenu", s:cyan, s:dark_charcoal)

" Term colors


" CoC
" call Highlight("CocErrorHighlight", s:blood_red)
" call Highlight("CocWarningHighlight", s:orange)
" call Highlight("CocHintHighlight", s:lime)
" call Highlight("CocInfoHighlight", s:grey)

call Highlight("CocErrorSign", s:danger, s:columns_bg)
call Highlight("CocWarningSign", s:orange, s:columns_bg)
call Highlight("CocHintSign", s:lime, s:columns_bg)
call Highlight("CocInfoSign", s:grey, s:columns_bg)

call Highlight("CocErrorVirtualText", s:dark_red, s:none, s:italic)
call Highlight("CocWarningVirtualText", s:orange, s:none, s:italic)
call Highlight("CocHintVirtualText", s:lime, s:none, s:italic)
call Highlight("CocInfoVirtualText", s:grey, s:none, s:italic)
