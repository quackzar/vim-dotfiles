" ======== LATEX ========
Plug 'lervag/vimtex'
let g:tex_flavor = "latex"
let g:tex_comment_nospell=1
let g:vimtex_latexmk_progname = 'nvr'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \   '-output-directory=out',
    \ ],
    \}

" let g:vimtex_complete_enabled=0


if has('macunix')
  let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
  let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
  let g:vimtex_view_method = 'skim'
endif

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
