setlocal foldmethod=expr
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
" setlocal formatprg=latexindent
setlocal keywordprg=texdoc
setlocal wrap
" nnoremap <buffer> <leader>v :VoomToggle<cr>
" nnoremap <silent><M-tab> :Vista focus<cr>
nmap <silent><buffer> <leader>v <plug>(vimtex-toc-toggle)
nmap <silent><buffer> <M-tab> <plug>(vimtex-toc-open)

nnoremap <buffer> <localleader>wc :VimtexCountWords<cr>
xnoremap <buffer> <localleader>wc :VimtexCountWords<cr>

" nnoremap <buffer> K <Plug>(vimtex-doc-package)

" So the other one doesn't seem to work, so I did this instead
nnoremap <buffer> K :VimtexDocPackage<cr>y<esc>

nnoremap <buffer> <F7> <Plug>(vimtex-cmd-create)

nnoremap <buffer> <silent> <leader>t :call vimtex#fzf#run('ctli', g:fzf_layout)<cr>
