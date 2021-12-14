" interface.vim
" ---------------
" Stuff to make (neo)vim prettier.

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

Plug 'norcalli/nvim-colorizer.lua'

" Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'yamatsum/nvim-web-nonicons'

Plug 'glepnir/dashboard-nvim'
" let g:dashboard_default_executive ='fzf'
let g:dashboard_default_executive ='telescope'
nnoremap <silent> <Leader>h :DashboardFindHistory<CR>
nnoremap <silent> <Leader>f :DashboardFindFile<CR>
nnoremap <silent> <Leader>Dc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>Dm :DashboardJumpMark<CR>
nnoremap <silent> <Leader>Dw :DashboardFindWord<CR>
nnoremap <silent> <Leader>Dn :DashboardNewFile<CR>

nmap <Leader>Ds :<C-u>SessionSave<CR>
nmap <Leader>Dl :<C-u>SessionLoad<CR>


" let g:dashboard_custom_shortcut={
"             \ 'find_file'          : 'SPC f  ',
"             \ 'find_history'       : 'SPC h  ',
"             \ 'find_word'          : 'SPC d w',
"             \ 'last_session'       : 'SPC s l',
"             \ 'change_colorscheme' : 'SPC t c',
"             \ 'book_marks'         : 'SPC d m',
"             \ 'new_file'           : 'SPC c n',
"             \ }

let g:dashboard_custom_shortcut={
            \ 'find_file'          : 'SPC f  ',
            \ 'find_history'       : 'SPC h  ',
            \ 'new_file'           : 'SPC D n',
            \ 'last_session'       : 'SPC D l',
            \ 'find_word'          : 'SPC D w',
            \ 'book_marks'         : 'SPC D b',
            \ 'change_colorscheme' : 'SPC D c',
            \ }


" let g:dashboard_preview_file = stdpath('config').'/neovim.cat'
" let g:dashboard_preview_file_height = 12
" let g:dashboard_preview_file_width = 80
" let g:dashboard_preview_command = 'cat'

augroup my_dashboard
    autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
    autocmd FileType dashboard set laststatus=0 | autocmd WinLeave <buffer> set laststatus=2
    autocmd FileType dashboard nnoremap <buffer> q :q<cr>
    autocmd FileType dashboard nmap <buffer> <cr> :
augroup END

Plug 'rcarriga/nvim-notify'

Plug 'folke/which-key.nvim'


Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
autocmd CmdlineEnter * ++once call s:wilder_init()

function! s:wilder_init() abort
    call wilder#setup({'modes': [':', '/', '?']})
    call wilder#set_option('use_python_remote_plugin', 0)
    call wilder#set_option('pipeline', [
        \   wilder#branch(
        \     wilder#cmdline_pipeline({
        \       'fuzzy': 1,
        \       'fuzzy_filter': wilder#lua_fzy_filter(),
        \     }),
        \     wilder#vim_search_pipeline(),
        \   ),
        \ ])
    call wilder#set_option('renderer', wilder#renderer_mux({
        \ ':': wilder#popupmenu_renderer({
        \   'highlighter': wilder#lua_fzy_highlighter(),
        \   'left': [
        \     ' ',
        \     wilder#popupmenu_devicons(),
        \   ],
        \   'right': [
        \     ' ',
        \     wilder#popupmenu_scrollbar(),
        \   ],
        \ }),
        \ '/': wilder#wildmenu_renderer({
        \   'highlighter': wilder#lua_fzy_highlighter(),
        \ }),
        \ }))
endfunction



" Colorschemes
Plug 'RRethy/nvim-base16'

Plug 'folke/tokyonight.nvim'
Plug 'tiagovla/tokyodark.nvim'
Plug 'mhartington/oceanic-next'
Plug 'rose-pine/neovim'
Plug 'tanvirtin/monokai.nvim'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
let g:tokyodark_transparent_background = 1
