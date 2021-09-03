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



Plug 'ggandor/lightspeed.nvim'


Plug 'arp242/jumpy.vim' " Maps [[ and ]]

Plug 'farmergreg/vim-lastplace'


Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
nmap <Leader>/ <Plug>(AerojumpSpace)
nmap <Leader>? <Plug>(AerojumpBolt)
" nmap <Leader>/a <Plug>(AerojumpFromCursorBolt)
" nmap <Leader>/d <Plug>(AerojumpDefault) " Boring mode
