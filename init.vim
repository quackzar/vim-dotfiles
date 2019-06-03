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
    return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! StatusGit()
    let l:s = fugitive#head()
    if l:s == ''
        return ''
    endif
    return ' ' . l:s . ' '
endfunction

function! StatusLine(current, width)
    let l:s = ''
    if a:current
        let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
    else
        let l:s .= '%#CrystallineInactive#'
    endif
    if &buftype == 'terminal'
        let l:s .= ' %f '
    else
        let l:s .= ' %f%h%w%m%r '
    end
    if a:current
        let l:s .= crystalline#right_sep('', 'Fill')
                    \. ' %{StatusGit()} '
                    \. '%{StatusDiagnostic()}'
    endif
    let l:s .= '%='
    if a:current
        let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
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

set termguicolors " GUI colors

set hidden " something about hidden buffers

set nu " have numbers

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

set ignorecase " infercase
set smartcase

set wildmenu
set wildmode=full
set wildoptions=tagfile "pum is cool though

if !has('vimr') " Only works on 0.4
    set pumblend=20
end

set title

set diffopt+=internal,algorithm:patience,hiddenoff

set mouse=a
set ts=4 sw=4 et

set showbreak=↪\
" set list listchars=tab:→\ ,trail:⋅,nbsp:␣,extends:⟩,precedes:
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅


set foldmethod=expr "indent
set foldcolumn=0
set foldlevel=99
set foldlevelstart=10

set diffopt=vertical

" let &backupdir = 'backup//'
" let &directory = g:rootdirectory . 'swap//'
" let &undodir = 'undodir//'
set backupdir=backup//
set undodir=undo//
set directory=swap//

set undofile " persistant undo
set nobackup
set nowritebackup

set langmenu=en_US
set clipboard=unnamed

set signcolumn=yes
set shiftwidth=4
set expandtab

set updatetime=300
set cmdheight=2
set noshowmode

set inccommand=nosplit " realtime changes for ex-commands
set shortmess+=c

set showcmd
let mapleader = ","

set conceallevel=2
set concealcursor= "ni

set formatoptions+=j
set grepprg=rg\ --vimgrep

" ====== FUNCTIONS ========

function! NumberToggle()
    if(&relativenumber == 1)
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
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

" Alignment
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>w :Windows<CR>


" Toggles
nnoremap <silent> <Leader>k :call ToggleSpellCheck()<CR>
nnoremap <silent> <leader>l :call NumberToggle()<cr>
nnoremap <silent> <leader>c :call ConcealToggle()<cr>

" Keep selection with indention
vnoremap > >gv
vnoremap < <gv


tnoremap <C-X> <C-\><C-n>

nnoremap <leader>e :exe getline(line('.'))<cr>
command! WipeReg for i in range(34,122) 
            \| silent! call setreg(nr2char(i), []) | endfor

" CoC Stuff
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <c-space> coc#refresh()
nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> <leader>C  :<C-u>CocList commands<cr>

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nnoremap <silent> K :call <SID>show_documentation()<CR>

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
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Enter as confirm completion and expand
inoremap <silent><expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" ====== COLORS =======
colorscheme molokai
autocmd CursorHold * silent call CocActionAsync('highlight')
" hi Normal ctermbg=none
" hi NonText ctermbg=none
" hi LineNr ctermbg=none
" hi Conceal ctermbg=none
hi! link Conceal Normal


let g:terminal_color_0  = '#272822'
let g:terminal_color_1  = '#F92672'
let g:terminal_color_2  = '#A6E22E'
let g:terminal_color_3  = '#FD971F'
let g:terminal_color_4  = 'blue'
let g:terminal_color_5  = 'cyan'

" ========== WEIRD STUFF ============
" Removes trailing spaces on write.
" autocmd BufWritePre *.tex :%s/\s\+$//e
