" ====== Visuals ======
let g:airline_theme='molokai'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_highlighting_cache = 1

if has('gui_running') || has('gui_vimr') || has("nvim")
  colorscheme molokai
  let g:airline_powerline_fonts = 1
  let g:webdevicons_enable_ctrlp = 1
  let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
  if has('macunix') && ! has('gui_vimr')
    " set transparency=3
    set guifont=DejaVu_Sans_Mono_Nerd_Font_Complete_Mono:h13
  elseif has('win32')
    set guifont=DejaVuSansMono_Nerd_Font_Mono:h10
  endif
  hi Normal ctermbg=none
  hi NonText ctermbg=none
  hi LineNr ctermbg=none
else
  colorscheme molokai
  let g:webdevicons_enable = 0
endif


let g:limelight_paragraph_span = 0
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

highlight Conceal guifg=#66d9ef guibg=#272822
highlight BookmarkSign guifg=#66D9EF
