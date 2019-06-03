call plug#begin(g:rootDirectory . 'plugged/')

" ========= GOOD LOOKING STUFF =========
Plug 'rbong/vim-crystalline'
Plug 'ryanoasis/vim-devicons'


" ========== FZF & Files ============
Plug '/usr/local/opt/fzf'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

function! s:fzf_statusline()
  " Override statusline as you like
  setlocal statusline=%#LineNr#\ FZF\ %#CursorColumn#\ Searching\ in\ %{getcwd()}
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" See hidden stuff, ignore the .git directory
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

Plug 'rbgrouleff/bclose.vim'
let g:bclose_no_plugin_maps = 1
Plug 'francoiscabrol/ranger.vim'
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

" ========== DEFAULT+ =========
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'AndrewRadev/switch.vim'
Plug 'dylanaraps/root.vim'
Plug 'markonm/traces.vim'
Plug 'Konfekt/FastFold'

Plug 'junegunn/vim-slash'
Plug 'christoomey/vim-tmux-navigator'
Plug 'machakann/vim-swap'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-sleuth'

" ========== GIT ============
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'

" ========== BECOMING AN IDE 101 =============
Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'
Plug 'liuchengxu/vista.vim'
Plug 'kassio/neoterm'
Plug 'mbbill/undotree'


" SNIPPETS
Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" let g:SuperTabDefaultCompletionType    = '<C-n>'
" let g:SuperTabCrMapping                = 0
" let g:UltiSnipsExpandTriggerOrJump     = '<M-tab>'
" let g:UltiSnipsJumpForwardTrigger      = '<M-tab>'
" let g:UltiSnipsJumpBackwardTrigger     = '<S-tab>'


" THE LANGUAGE CLIENT + AUTOCOMPLETION
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}


" ======== WEIRD READING/WRITING STUFF ========
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1

Plug 'tpope/vim-abolish' " like substitute
Plug 'reedes/vim-textobj-sentence' " better sentence detection
Plug 'reedes/vim-litecorrect' " autocorrection!
augroup litecorrect
  autocmd!
  autocmd FileType markdown call litecorrect#init()
  autocmd FileType tex call litecorrect#init()
augroup END
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-pencil'


" ======== LATEX ========
Plug 'lervag/vimtex'
" TEX SETTINGS
let g:tex_flavor = "latex"
let g:tex_comment_nospell=1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
if has('macunix')
  let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
  let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
  let g:vimtex_view_method = 'skim'
endif
autocmd FileType tex let b:coc_pairs = [['\(','\)'], ['\[', '\]']]
autocmd FileType tex let b:coc_pairs_disabled = ['`', '<', "'"]

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

" ======== MARKDOWN ========
Plug 'gabrielelana/vim-markdown'
if has('macunix')
    Plug 'junegunn/vim-xmark', { 'do': 'make' }
endif

" ======== GRAPHVIZ ========
Plug 'wannesm/wmgraphviz.vim'


" ======== PYTHON =======
Plug 'tmhedberg/SimpylFold'

call plug#end()
filetype plugin indent on    " required
