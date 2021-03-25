" git.vim
" ------------
"  Stuff relevant to git, version control, diffs.
Plug 'tpope/vim-fugitive'

" Git graph
Plug 'junegunn/gv.vim'

" Character wise differences hightlighting
Plug 'rickhowe/diffchar.vim'

" Merging tool
Plug 'samoshkin/vim-mergetool'
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'

" Magit for neovim
Plug 'TimUntersberger/neogit'

command! -nargs=0 Gupdate AsyncRun git pull --ff-only --autostash
