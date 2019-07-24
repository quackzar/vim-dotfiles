set nocompatible
filetype off
set encoding=utf8
set fileencoding=utf8

" THE VIM DIRECTORY, WHERE VIM STUFF HAPPENS!
" set this value to where this file is.
let g:rootDirectory='~/.config/nvim/'
let &runtimepath.=g:rootDirectory

let g:python3_host_prog = '/usr/local/bin/python3'

" Because I can't concat with source
" Load the plugins
exec 'source ' . g:rootDirectory . 'plugins.vim'
syntax on


" ======== STATUS LINE ============
function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, ' ' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, ' ' . info['warning'])
    endif
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

function! StatusGit()
    let l:s = fugitive#head()
    if l:s == ''
        return ''
    endif
    return ' ' . l:s . ' '
endfunction

function! Get_gutentags_status(mods) abort
    let l:msg = ''
    " if index(a:mods, 'ctags') >= 0
    "    let l:msg .= '♨ '
    "  endif
    "  if index(a:mods, 'cscope') >= 0
    "    let l:msg .= '♺ '
    "  endif
     return l:msg
endfunction

function! VimTexStatus()
    let l:msg = ''
    let l:compiler = get(get(b:, 'vimtex', {}), 'compiler', {})
    if !empty(l:compiler)
        if has_key(l:compiler, 'is_running') && b:vimtex.compiler.is_running()
            if get(l:compiler, 'continuous')
                let l:msg .= ' '
            else
                let l:msg .= ' '
            endif
        endif
    endif
    return l:msg
endfunction

function! StatusLine(current, width)
    " LEFT SIDE
    let l:s = ''
    if a:current " Current mode
        let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
    else
        let l:s .= '%#CrystallineInactive#'
    endif
    if &buftype == 'terminal'
        let l:s .= ' %f '
    else
        let l:s .= ' %f%h%w'
                    \. '%{&mod ? "  " : ""}'
                    \. '%{&readonly ? "  " : ""}'
                    \. ' '
    end
    " Status and such
    if a:current
        let l:s .= crystalline#right_sep('', 'Fill')
                    \. ' %{StatusGit()} '
                    \. '%{StatusDiagnostic()}'
    endif
    let l:s .= '%='
    " RIGHT SIDE
    " Active options
    if a:current
        let l:s .= crystalline#left_sep('', 'Fill') . ' '
        let l:s .= '%{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
        " let l:s .= '%{gutentags#statusline_cb(function("Get_gutentags_status"))}'
        let l:s .= '%{VimTexStatus()}'
    endif

    if a:current
        let l:s .= crystalline#left_mode_sep('')
    endif
    if a:width > 80 && &buftype != 'terminal'
        let l:s .= ' %{WebDevIconsGetFileTypeSymbol()}'
                    \. '[%{&enc}]'
                    \. ' %{WebDevIconsGetFileFormatSymbol()} %l/%L %c%V %P '
    else
        let l:s .= ' '
    endif
    return l:s
endfunction
function! TabLine()
    let l:vimlabel = has("nvim") ?  " NVIM " : " VIM "
    return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'molokai'





" ========= PLUGIN INDEPENDENT SETTINGS ===========
set laststatus=2 " Status bar always show
set showtabline=2 " Tabline always show
if $TERM == "xterm-256color"
    set t_Co=256
endif

set secure

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
set wrap
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
set wildignore+=*.o,*.obj,*.pyc
" Ignore source control
set wildignore+=.git
" Ignore lib/ dirs since the contain compiled libraries typically
set wildignore+=build,lib,node_modules,public,_site,third_party
" Ignore images and fonts
set wildignore+=*.gif,*.jpg,*.jpeg,*.otf,*.png,*.svg,*.ttf
" Ignore case when completing

if has('nvim-0.4')
    set pumblend=20
endif

set title

set diffopt+=internal,algorithm:patience,hiddenoff


" Start scrolling slightly before the cursor reaches an edge
set scrolloff=5
set sidescrolloff=5
set sidescroll=3

set showbreak=↪\
" set list listchars=tab:→\ ,trail:⋅,nbsp:␣,extends:⟩,precedes:
set list listchars=tab:▷⋅,trail:⋅,nbsp:░, 
set fillchars=diff:⣿                " BOX DRAWINGS
set fillchars+=vert:┃               " HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
set fillchars+=fold:─
set fillchars=eob:\                 " Hide end of buffer ~


set foldmethod=expr "indent
set foldcolumn=0
set foldlevel=99
set foldlevelstart=10

set diffopt+=vertical,algorithm:histogram,indent-heuristic

" All these gets deleted by the os
set backupdir=/tmp/backup//
set directory=/tmp/swap//
set undodir=/tmp/undo//

set undofile " persistant undo
set nobackup
set nowritebackup

" Thesaurus and dictionary support
let &thesaurus=g:rootDirectory . 'thesaurus/words.txt'
set dictionary+=/usr/share/dict/words

set langmenu=en_US

set signcolumn=yes

set updatetime=300
set cmdheight=1
set noshowmode
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
let mapleader = ","

set conceallevel=2
set concealcursor= "ni

set formatoptions+=j
set grepprg=rg\ --vimgrep

set whichwrap=b,h,l,s,<,>,[,],~
set virtualedit=block    " allow cursor to move where there is no text in visual block mode
" set splitbelow
" set splitright

set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview
set complete-=i

set pumheight=25
set pumblend=10

" Wait for cursorhold to trigger
set updatetime=750
set splitright

" Automatically go into insert mode when entering terminal window
augroup terminal_insert
    autocmd!
    autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END


" Close quickfix with q, esc or C-C
augroup easy_close
    autocmd!
    autocmd FileType help,qf nnoremap <buffer> q :q<cr>
    autocmd FileType help,qf nnoremap <buffer> <Esc> :q<cr>
    autocmd FileType help,qf nnoremap <buffer> <C-c> :q<cr>
    " Undo <cr> -> : shortcut
augroup END

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


function! s:Registers( arguments )
    redir => l:registersOutput
    silent! execute 'registers' a:arguments
    redir END
    for l:line in split(l:registersOutput, "\n")
        if l:line !~# '^"\S\s*$'
            echo l:line
        endif
    endfor
endfunction

command! -nargs=? Registers call <SID>Registers(<q-args>)

" ======= MAPPINGS ========
" Basics
noremap <CR> :
noremap Q @@
noremap x "_x

" Buffer magic
noremap gb :bn<CR>
noremap gB :bp<CR>
noremap <leader><leader>bd :Bclose<cr>

" No highlighting
noremap <silent> <leader><space> :noh<CR> 


" Motion
map  F <Plug>(easymotion-bd-f)
nmap F <Plug>(easymotion-overwin-f)

" Alignment
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>w :Windows<CR>

vnoremap . :normal .<CR>
vnoremap @ :normal @

" Toggles
nnoremap <silent> <Leader>k :call ToggleSpellCheck()<CR>
nnoremap <silent> <leader>l :call NumberToggle()<cr>
nnoremap <silent> <leader>c :call ConcealToggle()<cr>
noremap <silent> <leader>p :call PearTreeToggle()<cr>

" Keep selection with indention
vnoremap > >gv
vnoremap < <gv

" Exit term
tnoremap <C-X> <C-\><C-n>

" Eval line
nnoremap <leader>e :exe getline(line('.'))<cr>
command! WipeReg for i in range(34,122) 
            \| silent! call setreg(nr2char(i), []) | endfor

" CoC Stuff

inoremap <silent><expr> <C-x><C-o> coc#refresh()
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <M-space> coc#refresh()
nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> <leader>C  :<C-u>CocList commands<cr>

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>? <Plug>(coc-diagnostic-info)
nnoremap <silent> K :call <SID>show_documentation()<CR>
let g:coc_snippet_next = '<M-j>'
let g:coc_snippet_prev = '<M-k>'

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 Pickcolor :call CocAction('pickColor')
command! -nargs=0 Changecolorrep :call CocAction('colorPresentation')
command! -bar -nargs=0 Config tabnew|
            \exe 'tcd '.g:rootDirectory|
            \exe 'e '  .g:rootDirectory . 'init.vim'|
            \exe 'vs ' .g:rootDirectory . 'plugins.vim'
command! -nargs=0 SnipConfig exe 'Files ' . g:rootDirectory . '/UltiSnips/'

" Tab as expand, jump and other.
" inoremap <silent><expr> <TAB>
"             \ pumvisible() ? coc#_select_confirm() :
"             \   coc#expandableOrJumpable() ? UltiSnips#ExpandSnippetOrJump() :
"             \       <SID>check_back_space() ? "\<TAB>" :
"             \           coc#refresh()

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Enter as confirm completion and expand
inoremap <silent><expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"


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

