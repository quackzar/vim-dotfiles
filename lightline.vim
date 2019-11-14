function! LightlineMode()
    return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
                \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
                \ &filetype ==# 'unite' ? 'Unite' :
                \ &filetype ==# 'vimfiler' ? 'VimFiler' :
                \ &filetype ==# 'vimshell' ? 'VimShell' :
                \ &filetype ==# 'voomtree' ? 'VOOM' :
                \ &filetype ==# 'vista_kind' ? 'Vista' :
                \ lightline#mode()
endfunction


function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction


function! LightlineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
                \ fname == '__Tagbar__' ? g:lightline.fname :
                \ fname =~ '__Gundo\|NERD_tree' ? '' :
                \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                \ &ft == 'unite' ? unite#get_status_string() :
                \ &ft == 'vimshell' ? vimshell#get_status_string() :
                \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ''.branch : ''
    endif
    return ''
endfunction

let g:lightline = {
            \ 'colorscheme': 'molokai',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'method' ] ]
            \ },
            \ 
            \ 'component_function': {
            \   'mode': 'LightlineMode',
            \   'readonly': 'LightlineReadonly',
            \   'filename': 'LightlineFilename',
            \   'gitbranch': 'LightlineFugitive',
            \   'fileformat': 'LightlineFileformat',
            \   'filetype': 'LightlineFiletype',
            \   'method': 'NearestMethodOrFunction',
            \ },
            \ 'component': {
            \   'lineinfo': ' %3l:%-2v',
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
            \ }
