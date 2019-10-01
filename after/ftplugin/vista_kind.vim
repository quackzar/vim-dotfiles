setlocal cursorline
setlocal fillchars=eob:\ 
nnoremap <buffer> <cr> :
nnoremap <buffer> <silent> <leader>v :Vista!!<cr>jk
nnoremap <buffer> <silent> <M-tab> :call vista#cursor#FoldOrJump()<cr>
nnoremap <buffer> q/ <nop>
nnoremap <buffer> q: <nop>
nnoremap <buffer> <silent> <C-]> :call vista#cursor#FoldOrJump()<cr>
