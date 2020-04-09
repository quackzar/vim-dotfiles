" Modified from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! NeatFoldText()
    let indent_level = indent(v:foldstart)
    let indent = repeat(' ',indent_level)
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '-' . printf("%10s", lines_count . ' lines') . ' '
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return indent . foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
" set foldtext=NeatFoldText()

Plug 'Konfekt/FastFold' " Faster folding
" New stuff

Plug 'arecarn/vim-clean-fold'
set foldtext=clean_fold#fold_text('_')
set foldmethod=expr
set foldexpr=clean_fold#fold_expr(v:lnum)



" Indent Guides
Plug 'Yggdroot/indentLine'

" Virtual text for better guides
let g:pretty_indent_namespace = nvim_create_namespace('pretty_indent')


function! PrettyIndent()
    let l:view=winsaveview()
    call cursor(1, 1)
    call nvim_buf_clear_namespace(0, g:pretty_indent_namespace, 1, -1)
    while 1
        let l:match = search('^$', 'W')
        if l:match ==# 0
            break
        endif
        let l:indent = cindent(l:match)
        if l:indent > 0
            call nvim_buf_set_virtual_text(
            \   0,
            \   g:pretty_indent_namespace,
            \   l:match - 1,
            \   [[repeat(repeat(' ', &shiftwidth - 1) . '¦', l:indent / &shiftwidth), 'IndentGuide']],
            \   {}
            \)
        endif
    endwhile
    call winrestview(l:view)

endfunction

augroup PrettyIndent
    autocmd!
    autocmd TextChanged * call PrettyIndent()
    autocmd BufEnter * call PrettyIndent()
    autocmd InsertLeave * call PrettyIndent()
augroup END
