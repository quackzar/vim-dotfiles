" Editor.vim
" ----------
" Plugins and settings relevant to 'editing', stuff that feels very vim like


Plug 'machakann/vim-swap'
Plug 'svermeulen/vim-yoink'
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
Plug 'svermeulen/vim-subversive'
nmap gs          <plug>(SubversiveSubstitute)
nmap gss         <plug>(SubversiveSubstituteLine)
nmap gS          <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s  <plug>(SubversiveSubstituteRange)
xmap <leader>s  <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)


Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'dylanaraps/root.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'machakann/vim-sandwich' " Surround replacment, with previews and stuff

Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:loaded_matchit = 1
Plug 'andymass/vim-matchup'
let g:matchup_surround_enabled = 1
let g:matchup_transmute_enabled = 1
let g:matchup_matchparen_deferred = 1
let g:matchup_override_vimtex = 1


" Let's you preview marks!
Plug 'Yilin-Yang/vim-markbar'
nmap <space>m  <Plug>ToggleMarkbar
let g:markbar_jump_to_mark_mapping  = 'G'
let g:markbar_num_lines_context = 3
let g:markbar_file_mark_format_string = '%s (%d, %d)'
let g:markbar_file_mark_arguments = ['fname', 'col', 'line']
hi link markbarContext String

Plug 'Konfekt/FastFold'
Plug 'junegunn/vim-slash' " Better in buffer search

" Let's you preview the registers
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_delay = 50

Plug 'https://gitlab.com/mcepl/vim-fzfspell' " Use fzf for z=


Plug 'mbbill/undotree'

Plug 'psliwka/vim-smoothie'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'tpope/vim-abolish' " like substitute
Plug 'reedes/vim-textobj-sentence' " better sentence detection
Plug 'reedes/vim-litecorrect' " autocorrection! Fixes stupid common mistakes
augroup litecorrect
  autocmd!
  autocmd FileType markdown call litecorrect#init()
  autocmd FileType tex call litecorrect#init()
augroup END
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-pencil'
