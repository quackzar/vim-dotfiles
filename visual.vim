" ====== Visuals ======
let g:airline_theme='molokai'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_highlighting_cache = 1
colorscheme molokai
hi Normal ctermbg=none
hi NonText ctermbg=none
hi LineNr ctermbg=none
let g:airline_powerline_fonts = 1

if has('gui_running') || has('gui_vimr') || has("nvim")
  " let g:webdevicons_enable_ctrlp = 1
  let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
  if has('macunix') && ! has('gui_vimr')
    set guifont=DejaVu_Sans_Mono_Nerd_Font_Complete_Mono:h13
  elseif has('win32')
    set guifont=DejaVuSansMono_Nerd_Font_Mono:h10
  endif
else
  let g:webdevicons_enable = 0
endif


highlight GitGutterAddLine ctermfg=green
highlight GitGutterDeleteLine ctermfg=red
highlight GitGutterChangeLine ctermfg=yellow
highlight GitGutterChangeDeleteLine ctermfg=red

highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

highlight Conceal guifg=#66d9ef guibg=#272822
highlight BookmarkSign guifg=#66D9EF
