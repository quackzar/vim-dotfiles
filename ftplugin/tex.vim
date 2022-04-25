setlocal foldmethod=expr
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
setlocal keywordprg=texdoc
setlocal wrap
setlocal spell
nmap <silent><buffer> <leader>v <plug>(vimtex-toc-toggle)
nmap <silent><buffer> <M-tab> <plug>(vimtex-toc-open)

nnoremap <buffer> <localleader>wc :VimtexCountWords<cr>
xnoremap <buffer> <localleader>wc :VimtexCountWords<cr>

" nnoremap <buffer> K <Plug>(vimtex-doc-package)

" So the other one doesn't seem to work, so I did this instead
nnoremap <buffer> K :VimtexDocPackage<cr>y<esc>

nnoremap <buffer> <F7> <Plug>(vimtex-cmd-create)

" c: content, t: todo:, l: label, i: include
nnoremap <buffer> <silent> <leader>t :call vimtex#fzf#run('ctli', g:fzf_layout)<cr>

" In case these are already taken, reclaim them!
vmap <buffer> ac <plug>(vimtex-ac)
xmap <buffer> ac <plug>(vimtex-ac)
vmap <buffer> ic <plug>(vimtex-ic)
xmap <buffer> ic <plug>(vimtex-ic)

lua << EOF
  require('cmp').setup.buffer {
    formatting = {
      format = function(entry, vim_item)
          vim_item.menu = ({
            omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
            buffer = "[Buffer]",
            -- formatting for other sources
            })[entry.source.name]
          return vim_item
        end,
    },
    sources = {
      { name = 'omni' },
      { name = 'buffer' },
      -- other sources
    },
  }
EOF

