" interface.vim
" ---------------
" Stuff to make (neo)vim prettier.

Plug 'mhinz/vim-startify'
let g:startify_session_dir = stdpath('config').'/session/'
let g:startify_bookmarks = ['~/.config/nvim/init.vim']
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
let g:startify_update_oldfiles = 1
augroup my_startify
    autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
    autocmd User Startified nmap <buffer> <cr> :
    autocmd User Startified setlocal cursorline buflisted
augroup END

function! s:center(lines) abort
    let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
    let centered_lines = map(copy(a:lines),
                \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction

function! GetNVimVersion()
    redir => s
    silent! version
    redir END
    return matchstr(s, 'NVIM v\zs[^\n]*')
endfunction
let g:startify_custom_footer = s:center(['The Editor of the 21th Century'])

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
let g:ascii = [
            \ '                                        ▟▙            ',
            \ '                                        ▝▘            ',
            \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
            \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
            \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
            \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
            \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
            \ '',
            \]
let startify_custom_header = s:center(g:ascii) + [''] + s:center(['version '.GetNVimVersion()])

let g:startify_list_order = [
      \ ['   Files:'], 'dir',
      \ ['   Sessions:'], 'sessions',
      \ ['   MRU'], 'files',
      \ ['   Bookmarks:'], 'bookmarks',
      \ ]


let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ '^/tmp',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
      \ 'plugged/.*/doc',
      \ 'pack/.*/doc',
      \ '.*/vimwiki/.*'
      \ ]
" Plug 'skywind3000/vim-quickui'

noremap <silent> <C-q> :call quickui#menu#open()<cr>
