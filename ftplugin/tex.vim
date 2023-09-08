setlocal foldmethod=expr
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
setlocal keywordprg=texdoc
setlocal omnifunc=vimtex#complete#omnifunc
setlocal wrap
setlocal spell
setlocal tw=100 cc=100

" nmap <silent><buffer> <leader>v <plug>(vimtex-toc-toggle)
" nmap <silent><buffer> <M-tab> <plug>(vimtex-toc-open)
nmap <buffer> j gj
nmap <buffer> k gk
xmap <buffer> j gj
xmap <buffer> k gk

nnoremap <buffer> <localleader>wc :VimtexCountWords<cr>
xnoremap <buffer> <localleader>wc :VimtexCountWords<cr>

" reclaim keywordprg mapping
nnoremap <buffer> K K

" So the other one doesn't seem to work, so I did this instead
" nnoremap <buffer> K :VimtexDocPackage<cr>y<esc>


" In case these are already taken, reclaim them!
omap <buffer> ac <plug>(vimtex-ac)
xmap <buffer> ac <plug>(vimtex-ac)
omap <buffer> ic <plug>(vimtex-ic)
xmap <buffer> ic <plug>(vimtex-ic)
