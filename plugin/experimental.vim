" Experimental.vim
" ----------------
" Plugins that are new and exciting but not a staple yet
"
Plug 'zdcthomas/medit'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
let g:lens#disabled = 1

let g:lens#disabled_filetypes = ['nerdtree',
            \ 'fzf',
            \ 'coc-explorer',
            \ 'coc-finder',
            \ 'vista',
            \ 'GV',
            \ 'voomtree',
            \ 'vista_kind',
            \ 'peekaboo',
            \ 'markbar' ]

Plug 'lambdalisue/suda.vim'

Plug 'markonm/traces.vim'
" not only the / but :s and :g too

Plug 'machakann/vim-highlightedyank'

Plug 'wellle/context.vim'
let g:context_enabled = 0
let g:context_highlight_normal = 'Opaque'


Plug 'norcalli/nvim-colorizer.lua'


Plug 'dstein64/vim-startuptime'
