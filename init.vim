set encoding=utf8
setglobal fileencoding=utf8

if has('macunix')
    set shell=/usr/local/bin/fish
    " let g:python3_host_prog = '/usr/bin/python3'
    let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.6/bin/python3'
else
    set shell=/bin/fish
    let g:python3_host_prog = '/usr/bin/python3'
end

set runtimepath+=$HOME/.config/nvim

let mapleader = " "
call plug#begin(stdpath('config').'/plugged/')
     runtime! plugin/fzf.vim
     runtime! plugin/git.vim
     runtime! plugin/ide.vim
     runtime! plugin/tex.vim
     runtime! plugin/editor.vim
     runtime! plugin/folding.vim
     runtime! plugin/interface.vim
     runtime! plugin/lightline.vim
     runtime! plugin/languages.vim
     runtime! plugin/navigation.vim
     runtime! plugin/experimental.vim
call plug#end()
exe 'source' . stdpath('config').'/quickui.vim'
exe 'source' . stdpath('config').'/luastuff.vim'


" ========= PLUGIN INDEPENDENT SETTINGS ===========
if $TERM == "xterm-256color"
    set t_Co=256
endif

set langmenu=en_US

syntax on
set termguicolors " GUI colors

lua require'colorizer'.setup()
set hidden
set nu " have numbers

set mouse=a

set breakindent
set linebreak
set backspace=indent,eol,start
set nowrap
set autoread
set shiftwidth=4
set tabstop=4
set shiftround
set expandtab
set smarttab
set autoindent

set ignorecase " infercase
set smartcase

set wildmenu
set wildmode=full
set wildoptions=tagfile "pum is cool though
set wildignore+=*.o,*.obj,*.pyc,.git,.svn,*.a,*.class,*.mo,*.la,*.so
set wildignore+=*.ttf,\*.obj,*.swp,*.jpg,*.pdf,*.png,*.xpm,*.gif,*.jpeg
set wildignore+=build,lib,node_modules,public,_site,third_party
set suffixes+=.old
" Ignore lib/ dirs since the contain compiled libraries typically
" Ignore images and fonts
" Ignore case when completing

set title
set laststatus=2 " Status bar always show
set showtabline=2 " Tabline always show

" Start scrolling slightly before the cursor reaches an edge
set scrolloff=5
set sidescrolloff=5
set sidescroll=1

set showbreak=↪\
" set list listchars=tab:→\ ,trail:⋅,nbsp:␣,extends:⟩,precedes:
set list listchars=tab:▷⋅,trail:⋅,nbsp:░, 
set fillchars=diff:⣿                " BOX DRAWINGS
set fillchars=vert:┃               " HEAVY VERTICAL (U+2503)
set fillchars=eob:\ 
set fillchars=fold:\ 

set foldcolumn=0
set foldlevel=99
set foldlevelstart=10

set diffopt+=vertical,algorithm:histogram,indent-heuristic

" All these gets deleted by the os eventually
set backupdir=/tmp/backup//
set directory=/tmp/swap//
set undodir=/tmp/undo//

set undofile " persistant undo
set nobackup
set nowritebackup

set modelineexpr

" Thesaurus and dictionary support
let &thesaurus=stdpath('config').'/thesaurus/words.txt'
set dictionary+=/usr/share/dict/words

set langmenu=en_US

set signcolumn=auto:1

set cmdheight=1
set noshowmode " No need for that
set shortmess+=A      " ignore annoying swapfile messages
set shortmess+=I      " no splash screen
set shortmess+=O      " file-read message overwrites previous
set shortmess+=T      " truncate non-file messages in middle
set shortmess+=W      " don't echo "[w]"/"[written]" when writing
set shortmess+=a      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o      " overwrite file-written messages
set shortmess+=t      " truncate file messages at start
set shortmess+=c

" set inccommand=nosplit " realtime changes for ex-commands


set conceallevel=2

set whichwrap=b,s,<,>,[,],~
set virtualedit=block,onemore
" allow cursor to move where there is no text in visual block mode

set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview
set complete-=i

set pumheight=25
set pumblend=20
set winblend=20

let g:netrw_fastbrowse = 0

set updatetime=300

autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber

" Close quickfix with q, esc or C-C
augroup easy_close
    autocmd!
    autocmd FileType help,qf nnoremap <buffer> q :q<cr>
    autocmd FileType qf nnoremap <buffer> <Esc> :q<cr>
augroup END

autocmd FileType qf nnoremap <buffer> <C-]> <CR>
" autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

" autocmd BufReadPost *
"             \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
"             \ |   exe "normal! g`\""
"             \ | endif

" These nice commands triggers autoreading
augroup improved_autoread
  autocmd!
  autocmd FocusGained * silent! checktime
  autocmd BufEnter * silent! checktime
  autocmd VimResume * silent! checktime
  autocmd TermLeave * silent! checktime
augroup end

" ======= MAPPINGS ========
" Basics
noremap <CR> :
noremap Q :close<cr>
noremap gQ :bd<cr>
noremap x "_x
noremap X "_X

noremap Y y$

inoremap <silent> <C-s> <C-o>:w<cr>

" Annoying with a trackpad
noremap <ScrollWheelLeft> <nop>
noremap <ScrollWheelRight> <nop>

" Buffer magic
noremap gb :bn<CR>
noremap gB :bp<CR>

nnoremap <silent> <C-^> :<C-u>exe
            \ v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<CR>

" No highlighting
noremap <silent> <space><space> :noh<CR>

vnoremap . :normal .<CR>
vnoremap @ :normal @<CR>

" Keep selection with indention
vnoremap > >gv
vnoremap < <gv

" Terminal magic
tnoremap <C-Z> <C-\><C-n>

" ====== COLORS =======
let g:neomolokai_no_bg=1 " Remove the normal background
let g:neomolokai_inv_column=1 " Set the sign/number column bg to be the same as normal
colorscheme neomolokai

set secure
