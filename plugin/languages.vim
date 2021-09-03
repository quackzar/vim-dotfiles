" ==========  C  ==========
Plug 'justinmk/vim-syntax-extra'

Plug 'shirk/vim-gas'
Plug 'ARM9/arm-syntax-vim'


" ======== MARKDOWN ========
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_fenced_languages = ['go', 'c', 'python', 'tex', 'bash=sh', 'sh', 'fish', 'javascript', 'viml=vim', 'html']

" ======== ASCIIDOC =======
Plug 'habamax/vim-asciidoctor'
let g:asciidoctor_fenced_languages = ['go', 'c', 'python', 'tex', 'sh', 'fish', 'javascript', 'vim', 'html']
let g:asciidoctor_syntax_conceal = 1
let g:asciidoctor_folding = 1

" ======== GRAPHVIZ ========
Plug 'liuchengxu/graphviz.vim', {'for': 'dot'}

" ======== TYPESCRIPT =======
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

" ======== PYTHON =======
" Plug 'vim-python/python-syntax', {'for': 'python'}
" let g:python_highlight_all = 1
Plug 'tmhedberg/SimpylFold', {'for': 'python'}
let g:python_highlight_space_errors = 0

Plug 'jpalardy/vim-slime'
let g:slime_target = "kitty"
let g:slime_python_ipython = 1
xmap <c-c><c-c> <Plug>SlimeRegionSend
nmap <c-c><c-c> <Plug>SlimeParagraphSend
nmap <c-c>v     <Plug>SlimeConfig

Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
let g:ipython_cell_delimit_cells_by = 'tags'

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
let g:gopher_map = {'_default': 1, '_nmap_prefix': '<localleader>', '_imap_prefix': '<C-k>'}
Plug 'sebdah/vim-delve', {'for': 'go'}
let g:delve_breakpoint_sign = '●'
let g:delve_breakpoint_sign_highlight = 'CocHintSign'
let g:delve_tracepoint_sign = '◆'
let g:delve_tracepoint_sign_highlight = 'CocWarningSign'

" ===== vimwiki =====
Plug 'vimwiki/vimwiki'
let g:vimwiki_folding = 'expr'

Plug 'cespare/vim-toml'

" === kitty ===
Plug 'fladson/vim-kitty'


" === Coq ===
Plug 'whonore/Coqtail'
let g:coqtail_auto_set_proof_diffs = 'on'
