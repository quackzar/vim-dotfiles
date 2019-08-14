setlocal foldmethod=expr
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
setlocal wrap
nnoremap <buffer> <leader>v :VoomToggle<cr>
