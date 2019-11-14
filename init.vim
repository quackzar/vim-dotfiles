set encoding=utf8
setglobal fileencoding=utf8

if &shell =~# 'fish$'
    set shell=zsh
endif

" THE VIM DIRECTORY, WHERE VIM STUFF HAPPENS!
" set this value to where this file is.
let g:rootDirectory='~/.config/nvim/'
exec 'set runtimepath+=' . expand(g:rootDirectory)

let g:python3_host_prog = '/usr/local/bin/python3'
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" exec "set rtp+=" . g:opamshare . "/merlin/vim/"

" Because I can't concat with source
" Load the plugins
exec 'source ' . g:rootDirectory . 'plugins.vim'
syntax on


function! FoldText()
    let l:lpadding = &fdc
    redir => l:signs
    execute 'silent sign place buffer='.bufnr('%')
    redir End
    let l:lpadding += l:signs =~ 'id=' ? 2 : 0

    if exists("+relativenumber")
        if (&number)
            let l:lpadding += max([&numberwidth,
                        \strlen(line('$'))]) + 1
        elseif (&relativenumber)
            let l:lpadding += max([&numberwidth, 
                        \strlen(v:foldstart - line('w0')),
                        \strlen(line('w$') - v:foldstart), 
                        \strlen(v:foldstart)]) + 1
        endif
    else
        if (&number)
            let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
        endif
    endif

    " expand tabs
    let l:start = substitute(getline(v:foldstart), '\t',
                \repeat(' ', &tabstop), 'g')
    let l:end = substitute(substitute(getline(v:foldend),
                \'\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')

    let l:info = ' (' . (v:foldend - v:foldstart) . ')'
    let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
    let l:width = winwidth(0) - l:lpadding - l:infolen

    let l:separator = ' … '
    let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
    let l:start = strpart(l:start , 0,
                \l:width - strlen(substitute(l:end, '.', 'x', 'g')) - l:separatorlen)
    let l:text = l:start . ' … ' . l:end

    return l:text . repeat(' ',
                \l:width - strlen(substitute(l:text, ".", "x", "g"))) . l:info
endfunction
set foldtext=FoldText()

function! Evaluate_ftplugin_path()
    return g:rootDirectory . "ftplugin/" . &filetype . ".vim"
endfunction

" ========= PLUGIN INDEPENDENT SETTINGS ===========
set laststatus=2 " Status bar always show
set showtabline=2 " Tabline always show
if $TERM == "xterm-256color"
    set t_Co=256
endif


set termguicolors " GUI colors

set hidden " something about hidden buffers

set nu " have numbers

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove tool bar
set guioptions-=r  "remove right scroll bar
set guioptions-=L  "remove left scroll bar

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
set wildmode=full
set wildoptions=tagfile "pum is cool though
set wildignore+=*.o,*.obj,*.pyc,.git,.svn,*.a,*.class,*.mo,*.la,*.so
set wildignore+=*.ttf,\*.obj,*.swp,*.jpg,*.pdf,*.png,*.xpm,*.gif,*.jpeg
set wildignore+=build,lib,node_modules,public,_site,third_party
set suffixes+=.old
" Ignore lib/ dirs since the contain compiled libraries typically
" Ignore images and fonts
" Ignore case when completing

set title



" Start scrolling slightly before the cursor reaches an edge
set scrolloff=5
set sidescrolloff=5
set sidescroll=1

set showbreak=↪\
" set list listchars=tab:→\ ,trail:⋅,nbsp:␣,extends:⟩,precedes:
set list listchars=tab:▷⋅,trail:⋅,nbsp:░, 
set fillchars=diff:⣿                " BOX DRAWINGS
set fillchars=vert:┃               " HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
set fillchars=eob:\ 
set fillchars=fold:\ 

set foldmethod=syntax "indent
set foldcolumn=0
set foldlevel=99
set foldlevelstart=10

set diffopt+=vertical,algorithm:histogram,indent-heuristic

" All these gets deleted by the os eventually
set backupdir=/tmp/backup//
set directory=/tmp/swap//
set undodir=/tmp/undo//
" set tags=/tmp/tags;

set undofile " persistant undo
set nobackup
set nowritebackup

" Thesaurus and dictionary support
let &thesaurus=g:rootDirectory . 'thesaurus/words.txt'
set dictionary+=/usr/share/dict/words

set langmenu=en_US

set signcolumn=auto

set updatetime=300
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

set inccommand=nosplit " realtime changes for ex-commands
set shortmess+=c

set showcmd
let mapleader = " "

set conceallevel=2
set concealcursor= "ni

set formatoptions+=j
set grepprg=rg\ --vimgrep

set whichwrap=b,h,l,s,<,>,[,],~
set virtualedit=block
" allow cursor to move where there is no text in visual block mode

set modelineexpr
set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview
set complete-=i

set pumheight=25
set pumblend=20

" Wait for cursorhold to trigger
set updatetime=250
set splitright

autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber


" Close quickfix with q, esc or C-C
augroup easy_close
    autocmd!
    autocmd FileType help,qf nnoremap <buffer> q :q<cr>
    autocmd FileType qf nnoremap <buffer> <Esc> :q<cr>
augroup END

autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>


" ====== FUNCTIONS ========

function! NumberToggle()
    if (&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

function! ToggleSpellCheck()
    set spell!
    if &spell
        echo "Spellcheck ON"
    else
        echo "Spellcheck OFF"
    endif
endfunction

function! ConcealToggle()
    if &conceallevel == 0
        echo "Conceal ON"
        setlocal conceallevel=2
    else
        echo "Conceal OFF"
        setlocal conceallevel=0
    endif
endfunction

function! WrapToggle()
    if &wrap == 0
        echo "Wrap ON"
        setlocal wrap
    else
        echo "Wrap OFF"
        setlocal nowrap
    endif
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" ======= MAPPINGS ========
" Basics
noremap <CR> :
noremap Q :close<cr>
noremap <leader>Q :bd<cr>
noremap x "_x



" Annoying with a trackpad
noremap <ScrollWheelLeft> <nop>
noremap <ScrollWheelRight> <nop>

" Buffer magic
noremap gb :bn<CR>
noremap gB :bp<CR>
noremap <leader><leader>bd :Bclose<cr>

" No highlighting
noremap <silent> <leader><space> :noh<CR>
noremap <silent> <space><space><space> :noh<CR>

" Alignment
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>w :Windows<CR>

vnoremap . :normal .<CR>
vnoremap @ :normal @<CR>

" Toggles
nnoremap <silent> <Leader>k :call ToggleSpellCheck()<CR>
nnoremap <silent> <leader>l :call NumberToggle()<cr>
nnoremap <silent> <leader>c :call ConcealToggle()<cr>
nnoremap <silent> <leader>u :call WrapToggle()<cr>

" nnoremap <silent> <leader>z :call FloatTerm()<cr>

" Keep selection with indention
vnoremap > >gv
vnoremap < <gv

" Terminal magic
tnoremap <C-X> <C-\><C-n>
" tmap <C-j> <C-\><C-n><C-j>
" tmap <C-k> <C-\><C-n><C-k>
" tmap <C-h> <C-\><C-n><C-h>
" tmap <C-l> <C-\><C-n><C-l>

command! -nargs=0 Reload :source $MYVIMRC
nnoremap <silent> <Leader>ef :tabe <C-r>=Evaluate_ftplugin_path()<CR><CR>

" Vista stuff, VOoM replaces Vista bindings for LaTeX and Markdown
nnoremap <silent> <leader>v :Vista!!<cr>
nnoremap <silent> <leader>t :Vista finder coc<cr>
nnoremap <silent> <M-tab> :Vista focus<cr>
nmap <leader>z :CocCommand explorer<CR>

" CoC Stuff
inoremap <silent><expr> <C-x><C-o> coc#refresh()
inoremap <silent><expr> <M-space> 
            \pumvisible() ? "\<C-y>" : coc#refresh()
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <leader>rn <Plug>(coc-rename)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nnoremap <silent> <leader>C  :<C-u>CocList commands<cr>

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>? <Plug>(coc-diagnostic-info)
nnoremap <silent> K :call <SID>show_documentation()<CR>

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 Pickcolor :call CocAction('pickColor')
command! -nargs=0 Changecolorrep :call CocAction('colorPresentation')
command! -bar -nargs=0 Config tabnew|
            \exe 'tcd '.g:rootDirectory|
            \exe 'e '  .g:rootDirectory . 'plugins.vim'|
            \exe 'e '  .g:rootDirectory . 'init.vim'
command! -nargs=0 SnipConfig exe 'Files ' . g:rootDirectory . '/UltiSnips/'
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" Completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" ====== COLORS =======
colorscheme neomolokai
let base16colorspace=256
" autocmd CursorHold * silent call CocActionAsync('highlight')


set secure
