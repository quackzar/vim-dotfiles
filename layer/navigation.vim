" Navigation.vim
" ---------------
" Stuff that helps you navigate buffers, files, text, windows...
"
"
"
" Tmux and such
" Plug 'christoomey/vim-tmux-navigator' " Makes <C-hjkl> work between windows from tmux
" Plug 'benmills/vimux' " Send commands to tmux

Plug 'dstein64/vim-win'
map <space>w <plug>WinWin

" Plug 'pechorin/any-jump.nvim'

" Plug 'junegunn/vim-slash' " Better in buffer search
Plug 'nacro90/numb.nvim'

Plug 'voldikss/vim-skylight'
nnoremap <silent>       gp    :Skylight file<CR>
vnoremap <silent>       gp    :Skylight file<CR>
nnoremap <silent>       go    :Skylight! file<CR>
vnoremap <silent>       go    :Skylight! file<CR>

Plug 'ggandor/lightspeed.nvim'

Plug 'arp242/jumpy.vim' " Maps [[ and ]]

Plug 'farmergreg/vim-lastplace'

Plug 'kyazdani42/nvim-tree.lua'
nmap <silent> <leader>z :NvimTreeToggle<CR>

Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
nmap <Leader>/ <Plug>(AerojumpSpace)
nmap <Leader>? <Plug>(AerojumpBolt)
" nmap <Leader>/a <Plug>(AerojumpFromCursorBolt)
" nmap <Leader>/d <Plug>(AerojumpDefault) " Boring mode
