call plug#begin('~/.vim/plugged/')

" FZF and fuzzy finding
if has('win32')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
else
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
endif

" Autocomplete, linting and tags
Plug 'Cocophotos/vim-ycm-latex-semantic-completer'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" Plug 'ervandew/supertab'
Plug 'w0rp/ale' " Maybe this will be removed later

if has('win32')
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
                \ }
else
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }
endif

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/echodoc.vim'
Plug 'thalesmello/webcomplete.vim'


" Snippets
" Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Visuals
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'nathanaelkane/vim-indent-guides'

" Git specific
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
" Plug 'christoomey/vim-conflicted'
Plug 'sodapopcan/vim-twiggy'
Plug 'wting/gitsessions.vim'

" Running scripts, etc. in vim
Plug 'skywind3000/asyncrun.vim'
Plug 'pedsm/sprint'

" Stuff I maybe use
Plug 'lifepillar/vim-cheat40'
Plug 'wesQ3/vim-windowswap'
Plug 'wincent/terminus'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'sbdchd/neoformat'
Plug 'FredKSchott/CoVim' " Google Docs for vim

" Nice stuff you almost can't live without
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'AndrewRadev/switch.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'markonm/traces.vim'
Plug 'dylanaraps/root.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-easyoperator-line'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'Konfekt/FastFold'

" Language specific
Plug 'lervag/vimtex'
Plug 'nvie/vim-flake8'
Plug 'kchmck/vim-coffee-script'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'gabrielelana/vim-markdown'
Plug 'vim-scripts/indentpython.vim'
Plug 'jceb/vim-orgmode'

" Nerdtree and stuff not used in vimr
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

" For reading and writing text in markdown and the like
Plug 'reedes/vim-textobj-sentence'
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-pencil'
" Plug 'rhysd/vim-grammarous'
Plug 'tpope/vim-abolish'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'junegunn/vim-emoji'
if has('macunix')
    Plug 'junegunn/vim-xmark', { 'do': 'make' }
endif

call plug#end()            " required

" All of your Plugs must be added before the following line
filetype plugin indent on    " required
