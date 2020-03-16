Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

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
    return &ft =~ 'help' ? '' : &modified ? '' : &modifiable ? '' : ''
endfunction

function! LightlineFileformat() " show if not unix
    return winwidth(0) > 70 ? (&fileformat == 'unix' ? '' : &fileformat) : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction


lua spinner = require("spinner")

let g:spinner_running = 0
function AsyncRunStatus()
    if g:asyncrun_status == 'running'
        call luaeval("require'spinner'.start()")
        return luaeval("require'spinner'.state()")
    else
        call luaeval("require'spinner'.stop()")
        return ''
    endif
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
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:lightline = {
            \ 'colorscheme': 'molokai',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'filename', 'method' ],
            \             [ 'cocstatus' ]  ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'spell',  'fileformat', 'filetype'],
            \            [ 'asyncstatus' ]]
            \  },
            \ 'component_function': {
            \   'mode': 'LightlineMode',
            \   'filename': 'LightlineFilename',
            \   'gitbranch': 'LightlineFugitive',
            \   'fileformat': 'LightlineFileformat',
            \   'filetype': 'LightlineFiletype',
            \   'method': 'NearestMethodOrFunction',
            \   'abpi': 'LightlineABPI',
            \   'cocstatus': 'coc#status',
            \   'asyncstatus': 'AsyncRunStatus',
            \ },
            \ 'component': {
            \   'lineinfo': ' %3l:%-2v',
            \   'buffers': 'tabsel',
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel'
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ 'tabline': {'left': [['buffers']], 'right': [['close']]}
            \ }

            " \ 'separator': { 'left': '', 'right': '' },
            " \ 'subseparator': { 'left': '', 'right': '' },
" Tabline
" let g:lightline#bufferline#read_only = ''
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#unnamed = ' '
let g:lightline#bufferline#min_buffer_count = 2

let g:lightline#bufferline#number_map = {
    \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
    \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
    \ }
let g:lightline#bufferline#enable_devicons = 1


let g:lightline#bufferline#show_number = 2
nmap <space>1 <Plug>lightline#bufferline#go(1)
nmap <space>2 <Plug>lightline#bufferline#go(2)
nmap <space>3 <Plug>lightline#bufferline#go(3)
nmap <space>4 <Plug>lightline#bufferline#go(4)
nmap <space>5 <Plug>lightline#bufferline#go(5)
nmap <space>6 <Plug>lightline#bufferline#go(6)
nmap <space>7 <Plug>lightline#bufferline#go(7)
nmap <space>8 <Plug>lightline#bufferline#go(8)
nmap <space>9 <Plug>lightline#bufferline#go(9)
nmap <space>0 <Plug>lightline#bufferline#go(10)
