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
set foldmethod=indent
set foldlevel=99
syntax on
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

" ======= Sub-settings =======
source ~/.vim/misc.vim
source ~/.vim/visual.vim
source ~/.vim/latex.vim
source ~/.vim/python.vim
source ~/.vim/nerdtree.vim
source ~/.vim/screenrestore.vim

" ====== MAPPINGS ======
" Basics
nnoremap <CR> :
vnoremap <CR> :
map Q <Nop>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Motion
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

" Toggles
nnoremap <leader>m :TagbarToggle<CR>
nnoremap <leader>y :call YCMToggle()<CR>
nnoremap <silent> <Leader>k :call ToggleSpellCheck()<CR>
nnoremap <silent> <leader>nt :call NumberToggle()<cr>
nnoremap <leader>r :Switch<CR>
vnoremap <leader>r :Switch<CR>

" Stop highlighting
noremap <silent> <C-/> :noh<CR>

" Fuzzy finding
nnoremap <silent> <leader>f :Files<CR>

" Enable folding with the space bar
nnoremap <space> za

" Completion
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" === Fix, needs to be here ===
if exists("g:loaded_webdevicons") && ! has('gui_vimr')
  call webdevicons#refresh()
endif
