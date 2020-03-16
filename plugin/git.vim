" git.vim
" ------------
"  Stuff relevant to git, version control, diffs.
Plug 'tpope/vim-fugitive'


Plug 'junegunn/gv.vim'

Plug 'whiteinge/diffconflicts'
Plug 'rickhowe/diffchar.vim'

Plug 'samoshkin/vim-mergetool'
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'


command! -nargs=0 Gupdate AsyncRun git pull --rebase --autostash
