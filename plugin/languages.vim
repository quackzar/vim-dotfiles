" ==========  C  ==========
Plug 'justinmk/vim-syntax-extra'

" ======== MARKDOWN ========
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" ======== GRAPHVIZ ========
Plug 'wannesm/wmgraphviz.vim', {'for': 'dot'}

" ======== TYPESCRIPT =======
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

" ======== PYTHON =======
Plug 'vim-python/python-syntax', {'for': 'python'}
let g:python_highlight_all = 1
Plug 'tmhedberg/SimpylFold', {'for': 'python'}
let g:python_highlight_space_errors = 0
" ======== SWIFT ======
Plug 'keith/swift.vim', {'for': 'swift'}
Plug 'kentaroi/ultisnips-swift', {'for': 'swift'}

" ======= R =======
Plug 'jalvesaq/Nvim-R', {'for': 'R'} " R IDE

" ======= OCAML ======
Plug 'ELLIOTTCABLE/vim-menhir', {'for': ['ocaml', 'reasonml']}

" ====== LLVM ====
Plug 'rhysd/vim-llvm', {'for': 'llvm'}

" ======== GO ======
Plug 'arp242/gopher.vim', {'for': 'go'}
let g:gopher_map = 0
let g:gopher_map = {'_nmap_prefix': '<localleader>', '_imap_prefix': '<C-k>'}
Plug 'sebdah/vim-delve', {'for': 'go'}
let g:delve_breakpoint_sign = '●'
let g:delve_breakpoint_sign_highlight = 'CocHintSign'
let g:delve_tracepoint_sign = '◆'
let g:delve_tracepoint_sign_highlight = 'CocWarningSign'

" ===== Other cool stuff =====
Plug 'vimwiki/vimwiki'
Plug 'cespare/vim-toml'
