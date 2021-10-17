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
let g:dashboard_default_executive ='fzf'
nnoremap <silent> <Leader>h :DashboardFindHistory<CR>
nnoremap <silent> <Leader>f :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>dm :DashboardJumpMark<CR>
nnoremap <silent> <Leader>dw :DashboardFindWord<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>


let g:dashboard_custom_shortcut={
            \ 'find_file'          : 'SPC f  ',
            \ 'find_history'       : 'SPC h  ',
            \ 'find_word'          : 'SPC d w',
            \ 'last_session'       : 'SPC s l',
            \ 'change_colorscheme' : 'SPC t c',
            \ 'book_marks'         : 'SPC d m',
            \ 'new_file'           : 'SPC c n',
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


" Colorschemes
Plug 'folke/tokyonight.nvim'
Plug 'tiagovla/tokyodark.nvim'
let g:tokyodark_transparent_background = 1
