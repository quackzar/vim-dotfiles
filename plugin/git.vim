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

command! -bang -bar -nargs=* Gpush execute 'AsyncRun<bang> -cwd=' .
          \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'AsyncRun<bang> -cwd=' .
          \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>

Plug 'ruifm/gitlinker.nvim'

