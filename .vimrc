set nocompatible              " required
filetype off                  " required
set encoding=utf8
set fileencoding=utf8
set runtimepath+="~/.vim/"

if has('macunix') && !has('nvim')
  set pythonthreehome=/Library/Frameworks/Python.framework/Versions/3.6
  set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.6/lib/libpython3.6m.dylib
endif

source ~/.vim/plugins.vim
if $TERM == "xterm-256color"
  set t_Co=256
endif
set tgc

" Language Server/Client Stuff
set hidden
let g:LanguageClient_serverCommands = {
            \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
            \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
			\ 'ruby': ['solargraph', 'stdio'],
            \ 'python': ['/usr/local/bin/pyls'],
            \ 'javascript': ['/usr/local/lib/node_modules/typescript-language-server/lib/cli.js'],
            \ 'typescript': ['/usr/local/lib/node_modules/typescript-language-server/lib/cli.js']
            \ }
let g:LanguageClient_loadSettings = 1 
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
set completefunc=LanguageClient#complete
au BufRead,BufNewFile *.ts   setfiletype typescript
" ====== SETTINGS ======
let mapleader = ","
set nu
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove tool bar
set guioptions-=r  "remove right scroll bar
set guioptions-=L  "remove left scroll bar
set breakindent
set linebreak
set backspace=indent,eol,start
set autoread
set gdefault
set infercase
set smartcase
set wildmenu
set wildmode=full
set title
set conceallevel=2
set mouse=a
set ts=4 sw=4 et
set foldmethod=expr "indent
set foldlevel=99
set signcolumn=yes
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set updatetime=100
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
set diffopt=vertical
let g:gitgutter_diff_args = '-w'
let g:table_mode_corner='|'

syntax on
" ======= Sub-settings =======
source ~/.vim/misc.vim
source ~/.vim/fzf.vim
source ~/.vim/visual.vim
source ~/.vim/latex.vim
source ~/.vim/nerdtree.vim
source ~/.vim/screenrestore.vim

" ====== MAPPINGS ======
" Basics
nnoremap <CR> :
vnoremap <CR> :
map Q <Nop>

map gb :bn<CR>
map gB :bp<CR>
map ,b :Buffers<CR>

"" Split navigation
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Motion
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

nnoremap <C-space> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Toggles
nnoremap <leader>m :TagbarToggle<CR>
nnoremap <leader>y :call YCMToggle()<CR>
nnoremap <silent> <Leader>k :call ToggleSpellCheck()<CR>
nnoremap <silent> <leader>l :call NumberToggle()<cr>
nnoremap <leader>r :Switch<CR>
vnoremap <leader>r :Switch<CR>

" Stop highlighting
noremap <silent> <C-/> :noh<CR>

" Fuzzy finding
nnoremap <silent> <leader>f :call Fzf_dev()<cr>

" Enable folding with the space bar
nnoremap <space> za

" === Fix, needs to be here ===
if exists("g:loaded_webdevicons") && ! has('gui_vimr')
  call webdevicons#refresh()
endif
