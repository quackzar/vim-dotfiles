" Navigation.vim
" ---------------
" Stuff that helps you navigate buffers, files, text, windows...
"
"
"
" Tmux and such
Plug 'christoomey/vim-tmux-navigator' " Makes <C-hjkl> work between windows from tmux
Plug 'benmills/vimux' " Send commands to tmux

Plug 'dstein64/vim-win'
map <space>w <plug>WinWin

Plug 'pechorin/any-jump.nvim'

" Plug 'unblevable/quick-scope' " Highlights the first unique character
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" Plug 'rhysd/clever-f.vim'
Plug 'justinmk/vim-sneak'
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map S <Plug>SneakLabel_s
let g:sneak#label = 1
let g:sneak#prompt = 'SNEAK>'

Plug 'arp242/jumpy.vim' " Maps [[ and ]]

Plug 'farmergreg/vim-lastplace'
