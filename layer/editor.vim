" Editor.vim
" ----------
" Plugins and settings relevant to 'editing', stuff that feels very vim like
" All plugins either maps unused or extends upon a functionality without
" ruining the old mappings.

Plug 'duggiefresh/vim-easydir'

Plug 'aca/vidir.nvim'

Plug 'numToStr/Comment.nvim'

" Plug 'tpope/vim-commentary' " provides gc operator
Plug 'tpope/vim-speeddating' " allows <C-A> <C-X> for dates
Plug 'tpope/vim-repeat' " Improves dot
Plug 'tpope/vim-eunuch' " Basic (Delete, Move, Rename) unix commands
Plug 'tpope/vim-unimpaired'
Plug 'AndrewRadev/switch.vim'

Plug 'j5shi/CommandlineComplete.vim'

Plug 'machakann/vim-sandwich' " Surround replacment, with previews and stuff
nmap s <nop>
xmap s <nop>
xmap is <Plug>(textobj-sandwich-query-i)
xmap as <Plug>(textobj-sandwich-query-a)
omap is <Plug>(textobj-sandwich-query-i)
omap as <Plug>(textobj-sandwich-query-a)
xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)
xmap im <Plug>(textobj-sandwich-literal-query-i)
xmap am <Plug>(textobj-sandwich-literal-query-a)
omap im <Plug>(textobj-sandwich-literal-query-i)
omap am <Plug>(textobj-sandwich-literal-query-a)

Plug 'wellle/targets.vim'
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr lb ar ab lB Ar aB Ab AB rb rB bb bB BB'

let g:loaded_matchit = 1
Plug 'andymass/vim-matchup'
let g:matchup_surround_enabled = 0
let g:matchup_transmute_enabled = 1
let g:matchup_matchparen_deferred = 1
let g:matchup_override_vimtex = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}

Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


Plug 'Konfekt/vim-sentence-chopper'
let g:latexindent = 0


Plug 'markonm/traces.vim'
" not only the / but :s and :g too

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

Plug 'AndrewRadev/splitjoin.vim'
Plug 'flwyd/vim-conjoin'

" Funky stuff below

Plug 'machakann/vim-swap' " Swaps delimited things around g> g< gs

Plug 'mbbill/undotree'

" Let's you preview marks!
Plug 'Yilin-Yang/vim-markbar'
nmap <space>m  <Plug>ToggleMarkbar
let g:markbar_jump_to_mark_mapping  = 'G'
let g:markbar_num_lines_context = {
    \ 'around_local': 3,
    \ 'around_file': 0,
    \ 'peekaboo_around_local': 4,
    \ 'peekaboo_around_file': 2,
\ }

let g:markbar_file_mark_format_string = '%s (%d, %d)'
let g:markbar_file_mark_arguments = ['fname', 'col', 'line']
hi link markbarContext String
Plug 'kshenoy/vim-signature' " marks in the sign column
nnoremap <silent> gm :SignatureToggleSigns<cr>


" Let's you preview the registers
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_delay = 100

" Plug 'https://gitlab.com/mcepl/vim-fzfspell' " Use fzf for z=


Plug 'psliwka/vim-smoothie'

Plug 'andymass/vim-visput'

Plug 'lukas-reineke/indent-blankline.nvim'
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_char = '▏'
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_filetype_exclude = [
        \ 'help', 'text', 'undotree', 'vista', 'LuaTree',
        \ 'dashboard', 'markdown', '', 'man'
        \]

Plug 'tpope/vim-abolish' " like substitute
Plug 'reedes/vim-litecorrect' " autocorrection! Fixes stupid common mistakes
augroup litecorrect
  autocmd!
  autocmd FileType markdown call litecorrect#init()
  autocmd FileType tex call litecorrect#init()
augroup END
Plug 'reedes/vim-lexical'

" Plug 'skywind3000/vim-rt-format'
Plug 'kevinhwang91/nvim-bqf'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'dstein64/nvim-scrollview'
let g:scrollview_excluded_filetypes = ['LuaTree', 'vim-plug', 'vista', 'GV', 'peakaboo', 'markbar']

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
hi link TSError Normal
Plug 'romgrk/nvim-treesitter-context'
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'


Plug 'luukvbaal/stabilize.nvim'
