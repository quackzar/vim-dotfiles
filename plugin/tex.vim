" ======== LATEX ========
Plug 'lervag/vimtex'
let g:tex_flavor = "latex"
let g:tex_comment_nospell=1
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \ 'build_dir': 'out',
    \}

let g:vimtex_complete_enabled=1

let g:vimtex_format_enabled = 1
let g:vimtex_fold_enabled = 1

if executable('pulp')
    let g:vimtex_quickfix_method = 'pulp'
end

let g:vimtex_toc_config = {
            \ 'name' : 'Table of Contents',
            \ 'mode' : 1,
            \ 'fold_enable': 1,
            \ 'hotkeys_enabled': 1,
            \ 'resize': 0,
            \ 'refresh_always': 1,
            \}

" augroup vimtex
"     autocmd!
"     autocmd BufWritePost *.tex call vimtex#toc#refresh()
" augroup END


" let g:vimtex_view_general_callback = ''


if has('macunix')
    let g:vimtex_textidote_jar = '~/Applications/textidote.jar'
    let g:vimtex_view_general_viewer
                \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_options = '-r @line @pdf @tex'
    let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
    let g:vimtex_view_automatic = 1
    let g:vimtex_view_skim_reading_bar = 0
    let g:vimtex_view_method = 'skim'
else
    " function! MyTestHook(status)
    "   echom a:status
    " endfunction
    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_view_use_temp_files = 1
    let g:vimtex_view_automatic = 1
    " let g:vimtex_compiler_callback_hooks = ['MyTestHook']
    let g:vimtex_compiler_progname = 'nvr'
endif

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

" disables warnings and such

" " Disable all warnings
" let g:vimtex_quickfix_latexlog = {'default' : 0}

" " Disable undefined reference warnings
" let g:vimtex_quickfix_latexlog = {'references' : 0}

" " Disable overfull/underfull \hbox and all package warnings
" let g:vimtex_quickfix_latexlog = {
"             \ 'overfull' : 0,
"             \ 'underfull' : 0,
"             \ 'packages' : {
"             \   'default' : 0,
"             \ },
"             \}

