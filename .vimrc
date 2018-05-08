set nocompatible              " required
filetype off                  " required
set encoding=utf8
set fileencoding=utf8
set runtimepath+="~/.vim/"

if has('macunix')
  set pythonthreehome=/Library/Frameworks/Python.framework/Versions/3.6
  set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.6/lib/libpython3.6m.dylib
endif

call plug#begin('~/.vim/plugged/')
  Plug 'w0rp/ale'
    let ale_python_pylint_options='--max-line-length=120 --load-plugins pylint_django'
    let ale_python_flake8_options='--max-line-length=120 --load-plugins pylint_django'
    let g:ale_lint_on_enter=0
  Plug 'tmhedberg/SimpylFold'
  Plug 'ervandew/supertab'
  Plug 'easymotion/vim-easymotion'
  Plug 'haya14busa/vim-easyoperator-line'
  Plug 'justinmk/vim-sneak'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
  Plug 'Valloric/YouCompleteMe'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'scrooloose/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'dylanaraps/root.vim'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'nvie/vim-flake8'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'gregsexton/gitv'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-endwise'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'python-mode/python-mode'
  Plug 'anntzer/vim-cython'
  Plug 'vim-scripts/indentpython.vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'pedsm/sprint'
  Plug 'lervag/vimtex'
  Plug 'ryanoasis/vim-devicons'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'mbbill/undotree'
  Plug 'lifepillar/vim-cheat40'
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} " for VimPlug
  Plug 'wesQ3/vim-windowswap'
call plug#end()            " required

" All of your Plugs must be added before the following line
filetype plugin indent on    " required

set nu
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove tool bar
set guioptions-=r  "remove right scroll bar
set guioptions-=L  "remove left scroll bar
set breakindent
set linebreak
set backspace=indent,eol,start
set autoread
set gdefault
set infercase
set wildmenu
set wildmode=full
set title
set conceallevel=2
set mouse=a
set ts=4 sw=4 et
map Q <Nop>
let mapleader = ","
syntax on
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅

nnoremap <leader>m :TagbarToggle<CR>
map <C-8> <C-]>
map <C-9> <C-[>
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutBackInsert=''
let g:AutoPairsShortcutJump=''

if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

"split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <CR> :

let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'

" ============= CtrlP ===============
let g:ctrlp_exentions = ['tag', 'buffertag', 'bookmarkdir']

" =========== NERDTree ==============
autocmd FileType nerdtree setlocal nolist
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'
let g:root#patterns = ['.git', 'tags']
let NERDTreeIgnore = ['\.DAT$', '\.LOG1$', '\.LOG1$', '.pyc$', '\~$']
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" ===== Toggle spellchecking ======
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

nnoremap <silent> <Leader>k :call ToggleSpellCheck()<CR>

" ============ ALE ===========
let g:ale_fixers = {
            \'latex': ['remove_trailing_lines', 'trim_whitespace'],
            \}

" ======= Python stuff =======
hi pythonSelf  ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
set clipboard=unnamed
let python_highlight_all=1

filetype plugin indent on
  au FileType py set autoindent
  au FileType py set smartindent
  au FileType py set textwidth=79 " PEP-8 Friendly
autocmd BufWritePost *.py call Flake8()

" ====== Snippets and Completion ======
set runtimepath+=~/.vim/custom_snips/
let g:UltiSnipsSnippetsDir = '~/.vim/custom_snips/UltiSnips'

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" ======= Bookmarks =======
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_no_default_key_mappings = 1

" NERDTree Fix
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
    nmap ma :BookmarkShowAll<CR>
    nmap mc :BookmarkClear<CR>
    nmap mx :BookmarkClearAll<CR>
    nmap mkk :BookmarkMoveUp
    nmap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap ma
    unmap mc
    unmap mx
    unmap mkk
    unmap mjj
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()

" ======= Surround =======
let b:surround_{char2nr('e')}
      \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
let b:surround_{char2nr('c')} = "\\\1command: \1{\r}"

" ===== YCM Settings =====
let g:ycm_min_num_of_chars_for_completion = 3
function! YCMToggle()
  if(g:ycm_auto_trigger == 1)
    echo "YCM Manual Trigger"
    let g:ycm_auto_trigger=0
  else
    echo "YCM Auto Trigger"
    let g:ycm_auto_trigger=1
  endif
endfunc

nnoremap <leader>y :call YCMToggle()<CR>

" ====== Switch relative numbers =======
set showcmd
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <silent> <leader>nt :call NumberToggle()<cr>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the space bar
nnoremap <space> za

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let $PYTHONUNBUFFERED=1
map <F3> :NERDTreeToggle<CR>
map <F5> :AsyncRun -raw python3 %<CR>
noremap <F7> :AsyncRun gcc "%" -o "%<" <cr> 
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
let g:pymode_python = 'python3'

" ====== Visuals ======
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='molokai'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_highlighting_cache = 1
if has('gui_running')
  colorscheme molokai
  let g:airline_powerline_fonts = 1
  let g:webdevicons_enable_ctrlp = 1
  let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
  if has('macunix')
    set transparency=3
    set guifont=DejaVu_Sans_Mono_Nerd_Font_Complete_Mono:h12
  elseif has('win32')
    set guifont=DejaVuSansMono_Nerd_Font_Mono:h9
  endif
  hi Normal ctermbg=none
  hi NonText ctermbg=none
  hi LineNr ctermbg=none
else
  colorscheme molokai
  let g:webdevicons_enable = 0
endif

highlight Conceal guifg=#66d9ef guibg=#272822
highlight BookmarkSign guifg=#66D9EF

" ====== Save Session on exit ======
if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif


" ====== LaTeX =======
let g:tex_flavor = "latex"
let g:tex_comment_nospell=1


if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif

let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
      \ ]

set foldmethod=expr
set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()

if has('macunix')
  let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
  let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
elseif has('win32')
  let g:vimtex_view_general_viewer = 'C:/PROGRA~1/SumatraPDF/SumatraPDF.exe'
  let g:vimtex_view_general_options
      \ = ' -forward-search @tex @line @pdf'
      \ . ' -inverse-search "gvim --servername ' . v:servername
      \ . ' --remote-send \"^<C-\^>^<C-n^>'
      \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
      \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
      \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
      \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])


" === Fix, needs to be here ===
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
