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
Plug 'ervandew/supertab'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/echodoc.vim'

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
Plug 'christoomey/vim-conflicted'
Plug 'sodapopcan/vim-twiggy'
Plug 'wting/gitsessions.vim'

" Running scripts, etc. in vim
Plug 'skywind3000/asyncrun.vim'
Plug 'pedsm/sprint'

" Stuff I maybe use
Plug 'lifepillar/vim-cheat40'
Plug 'wesQ3/vim-windowswap'
Plug 'wincent/terminus'
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'

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
Plug 'tpope/vim-abolish'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tmhedberg/SimpylFold'

call plug#end()            " required

" All of your Plugs must be added before the following line
filetype plugin indent on    " required