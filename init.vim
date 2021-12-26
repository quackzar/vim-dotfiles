set encoding=utf8
setglobal fileencoding=utf8

set shell=fish
let $SHELL = "/bin/zsh"
let g:python3_host_prog = '/usr/bin/python3'
set pyxversion=3

set runtimepath+=$HOME/.config/nvim

let mapleader = " "
call plug#begin(stdpath('config').'/plugged/')
    Plug 'lewis6991/impatient.nvim'
    Plug 'nathom/filetype.nvim'
    " runtime layer/coc.vim
    runtime layer/editor.vim
    runtime layer/experimental.vim
    runtime layer/folding.vim
    " runtime layer/fzf.vim
    runtime layer/git.vim
    runtime layer/ide.vim
    runtime layer/languages.vim
    runtime layer/navigation.vim
    runtime layer/statusline.vim
    runtime layer/tex.vim
    runtime layer/ui.vim
call plug#end()

let g:did_load_filetypes = 1


" ====== LUA setup ======= {{{
lua require('impatient')
lua require('cfg.treesitter')
lua require('cfg.gitsigns')
lua require('cfg.telescope')
" lua require("grammar-guard").init()
lua require('cfg.dap')
lua require('cfg.lsp')
lua require('toggle_lsp_diagnostics').init()
lua require('neogit').setup {}
lua require('nvim-tree').setup {}
lua require('numb').setup()
lua require('gitlinker').setup()
lua require('Comment').setup()
lua require("stabilize").setup()
lua require('rust-tools').setup({})
lua require("todo-comments").setup{}
lua require("renamer").setup{}
lua require("twilight").setup {}
lua require('neoscroll').setup()


lua << EOF
wk = require("which-key")
wk.setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
    },
}

wk.register({
  ["<leader>"] = {
    f = {
      name = "+find",
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
      g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
      h = { "<cmd>Telescope help_tags<cr>", "Find help" },
    },
  },
})

EOF

" silent! lua require('galaxybar.bubblegum')
lua require('windline.bubblegum')
" silent! lua require('wlsample.bubble2')
"



if has('vscode')
    source vscode.vim
endif

" ========= PLUGIN INDEPENDENT SETTINGS =========== {{{
if $TERM == "xterm-256color"
    set t_Co=256
endif

set langmenu=en_US

syntax on
set termguicolors " GUI colors

silent! lua require('colorizer').setup()
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
set wildmode=longest:full,full
set wildoptions=tagfile,pum
set wildignore+=*.o,*.obj,*.pyc,.git,.svn,*.a,*.class,*.mo,*.la,*.so
set wildignore+=*.ttf,\*.obj,*.swp,*.jpg,*.pdf,*.png,*.xpm,*.gif,*.jpeg
set wildignore+=build,lib,node_modules,public,_site,third_party
set suffixes+=.old
" Ignore lib/ dirs since the contain compiled libraries typically
" Ignore images and fonts
" Ignore case when completing
"

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

set guicursor=n-v:block,i-ci-ve-c:ver25,r-cr:hor20,o:hor50


set undofile " persistant undo
set nobackup
set nowritebackup

let &spellfile='$HOME/.config/nvim/spell//'

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

augroup term_settings
    autocmd TermOpen * startinsert
    autocmd TermOpen * setlocal nonumber
augroup END
" Close quickfix with q, esc or C-C
augroup easy_close
    autocmd!
    autocmd FileType help,qf nnoremap <buffer> q :q<cr>
    autocmd FileType qf nnoremap <buffer> <Esc> :q<cr>
    autocmd FileType qf setlocal wrap
augroup END

autocmd FileType qf nnoremap <buffer> <C-]> <CR>
" autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

" These nice commands triggers autoreading
augroup improved_autoread
  autocmd!
  autocmd FocusGained * silent! checktime
  autocmd BufEnter    * silent! checktime
  autocmd VimResume   * silent! checktime
  autocmd TermLeave   * silent! checktime
augroup end
"}}}

if executable('rg')
  set grepprg=rg\ --vimgrep\ -g='!*.pdf'\ -g='!*.eps'\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ======= MAPPINGS ======== {{{
" Basics
noremap <CR> :
noremap Q :close<cr>
noremap gQ :bd<cr>
noremap x "_x
noremap X "_X

noremap Y y$

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

" vnoremap . :normal .<CR>
vnoremap @ :normal @<CR>

" Keep selection with indention
vnoremap > >gv
vnoremap < <gv

" Terminal magic
tnoremap <C-Z> <C-\><C-n>
tmap <esc> <esc><C-\><C-n>
" }}}

" ====== COLORS ======= {{{
let g:neomolokai_no_bg=1 " Remove the normal background
let g:neomolokai_inv_column=1 " Set the sign/number column bg to be the same as normal
colorscheme neomolokai

" }}}

set secure
" vim: foldmethod=marker
