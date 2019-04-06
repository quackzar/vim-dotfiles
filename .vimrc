set nocompatible              " required
filetype off                  " required
set encoding=utf8
set fileencoding=utf8
set runtimepath+="~/.vim/"

if has('macunix') && !has('nvim')
  set pythonthreehome=/Library/Frameworks/Python.framework/Versions/3.6
  set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.6/lib/libpython3.6m.dylib
endif
if has('macunix') && has('nvim')
  let g:python3_host_prog = '/usr/local/bin/python3'
  " let g:python3_host_prog = '/usr/local/bin/python2'
endif

source ~/.vim/plugins.vim
if $TERM == "xterm-256color"
  set t_Co=256
endif
set tgc " GUI colors

" Language Server/Client Stuff
set hidden
let g:LanguageClient_serverCommands = {
            \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
            \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
            \ 'ruby': ['solargraph', 'stdio'],
            \ 'python': ['/usr/local/bin/pyls'],
            \ 'javascript': ['/usr/local/lib/node_modules/typescript-language-server/lib/cli.js'],
            \ 'typescript': ['/usr/local/lib/node_modules/typescript-language-server/lib/cli.js'],
            \ 'go': ['bingo']
            \ }
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
set completefunc=LanguageClient#complete
au BufRead,BufNewFile *.ts setfiletype typescript
" ====== SETTINGS ======
let mapleader = ","
set nu
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove tool bar
set guioptions-=r  "remove right scroll bar
set guioptions-=L  "remove left scroll bar
set breakindent
set linebreak
set backspace=indent,eol,start
set wrap
set autoread
set gdefault
set infercase
set smartcase
set wildmenu
set wildmode=full
set title
set conceallevel=2
set mouse=a
set ts=4 sw=4 et
set showbreak=↪\
set list listchars=tab:→\ ,trail:⋅,nbsp:␣,extends:⟩,precedes:⟨
set foldmethod=expr "indent
set foldlevel=99
set foldlevelstart=10
" set fillchars=fold:\
set signcolumn=yes
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set updatetime=100
if has("persistent_undo")
    set undodir=~/.undodir//
    set undofile
endif
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
set diffopt=vertical
let g:gitgutter_diff_args = '-w'
let g:table_mode_corner='|'

set langmenu=en_US
set clipboard=unnamed

set signcolumn=yes
set shiftwidth=4
set expandtab


syntax on
" ======= Sub-settings =======
source ~/.vim/misc.vim
source ~/.vim/fzf.vim
source ~/.vim/visual.vim
source ~/.vim/latex.vim
source ~/.vim/nerdtree.vim
source ~/.vim/screenrestore.vim

" ====== MAPPINGS ======
" Basics
noremap <CR> :
map Q <Nop>
noremap x "_x

" Buffer magic
noremap gb :bn<CR>
noremap gB :bp<CR>
noremap ,b :Buffers<CR>

" Fuzzy finding,f
nnoremap <silent> <leader>f :Files<CR>
" Fzf_dev()<cr>

" Tags
nnoremap <leader>gt :TagbarToggle<CR>
nnoremap <leader>t :BTags<CR>

nnoremap <leader>w :Windows<CR>

" Enable folding with the space bar
nnoremap <space> za


"" Split navigation
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Motion
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

" Easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Toggles
nnoremap <leader>m :TagbarToggle<CR>
nnoremap <leader>y :call YCMToggle()<CR>
nnoremap <silent> <Leader>k :call ToggleSpellCheck()<CR>
nnoremap <silent> <leader>l :call NumberToggle()<cr>
nnoremap <silent> <leader>c :call ConcealToggle()<cr>
nnoremap <leader>r :Switch<CR>
xnoremap <leader>r :Switch<CR>
nnoremap <leader>v :Vista!!<CR>
let g:vista_fzf_preview = ['right:50%']

command! FixTrail let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>
command! FindNonASCII /[^\d0-\d127]

" Stop highlighting
noremap <silent> <leader><space> :noh<CR>

" Ultisnips

set runtimepath+=~/.vim/custom_snips/
let g:UltiSnipsSnippetsDir = '~/.vim/custom_snips/UltiSnips'

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTriggerOrJump     = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<S-tab>'

inoremap <expr><C-space> deoplete#mappings#manual_complete()
inoremap <expr><C-g> deoplete#undo_completion()
call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#option('ignore_sources', {
            \ '_': ['around'],
            \ 'dagbok': ['syntax'],
            \})

call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
call deoplete#custom#source('ultisnips', 'rank', 1000)

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
let g:deoplete#omni#input_patterns.tex =
        \   '\\(?:'
        \  .   '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
        \  .  '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
        \  .  '|hyperref\s*\[[^]]*'
        \  .  '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
        \  .  '|(?:include(?:only)?|input)\s*\{[^}]*'
        \  .')'
autocmd FileType tex
       \ call deoplete#custom#buffer_option('auto_complete', v:false)

" Echodoc
set cmdheight=1
set noshowmode
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" Language Client Stuff
nnoremap <M-space> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
    autocmd!
    autocmd FileType c,cpp,javascript,typescript,go,python call SetLSPShortcuts()
augroup END

"=== Fix, needs to be here ===
if exists("g:loaded_webdevicons") && ! has('gui_vimr')
  call webdevicons#refresh()
endif
