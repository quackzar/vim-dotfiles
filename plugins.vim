" This file should contain all plugins and their configurations.
" Keymaps may be omitted.
call plug#begin(g:rootDirectory . 'plugged/')

" ========= PURE EYE-CANDY =========
Plug 'rbong/vim-crystalline'
exec 'source ' . g:rootDirectory . 'statusline.vim'
" Plug 'itchyny/lightline.vim'
" exec 'source ' . g:rootDirectory . 'lightline.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'mhinz/vim-startify'
let g:startify_session_dir = g:rootDirectory . 'session/'
let g:startify_bookmarks = ['~/.config/nvim/init.vim', '~/.zshrc']
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
let g:startify_update_oldfiles = 1
autocmd User Startified nmap <buffer> <space><space><space> <plug>(startify-open-buffers)
autocmd User Startified nmap <buffer> <cr> :
autocmd User Startified setlocal cursorline
function! s:center(lines) abort
    let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
    let centered_lines = map(copy(a:lines),
                \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction

function! GetNVimVersion()
    redir => s
    silent! version
    redir END
    return matchstr(s, 'NVIM v\zs[^\n]*')
endfunction
let g:startify_custom_footer = s:center(['The Editor of the 21th Century'])

let g:ascii = [
            \ '                                        ▟▙            ',
            \ '                                        ▝▘            ',
            \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
            \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
            \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
            \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
            \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
            \ '',
            \]
let startify_custom_header = s:center(g:ascii) + [''] + s:center(['version '.GetNVimVersion()])

let g:startify_list_order = [
      \ ['   Files:'], 'dir',
      \ ['   Sessions:'], 'sessions',
      \ ['   MRU'], 'files',
      \ ['   Bookmarks:'], 'bookmarks',
      \ ]

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ '^/tmp',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
      \ 'plugged/.*/doc',
      \ 'pack/.*/doc',
      \ '.*/vimwiki/.*'
      \ ]

Plug 'norcalli/nvim-colorizer.lua'
" lua require 'colorizer'.setup()


" ========== FZF & File Navigation ============
Plug '/usr/local/opt/fzf'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Pmenu'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

let g:fzf_layout = { 'down': '~30%' }
let g:fzf_buffers_jump = 1


command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? -complete=dir GFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! CmdHist call fzf#vim#command_history({'right': '40'})
nnoremap q: :CmdHist<CR>

command! QHist call fzf#vim#search_history({'right': '40'})
nnoremap q/ :QHist<CR>

command! -nargs=1 Spotlight call fzf#run(fzf#wrap({
            \ 'source'  : 'mdfind -onlyin ~ <q-args>',
            \ 'options' : '-m --prompt "Spotlight> "'
            \ }))

command! FZFMulti call fzf#run(fzf#wrap({
            \'source': 'rg -l',
            \'options': ['--multi'],
            \}))

" autocmd! FileType fzf
" autocmd  FileType fzf set laststatus=0 noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 ruler

" See hidden stuff, ignore the .git directory
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'


" let $FZF_DEFAULT_OPTS = '--layout=reverse'
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'

let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

function! OpenFloatingWin()
    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)
    let opts = {
                \ 'relative': 'editor',
                \ 'row': height * 0.3,
                \ 'col': col + 30,
                \ 'width': width * 2 / 3,
                \ 'height': height / 2
                \ }
    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhl', 'Normal:Pmenu')
    setlocal
                \ buftype=nofile
                \ nobuflisted
                \ bufhidden=hide
                \ nonumber
                \ norelativenumber
                \ signcolumn=no
endfunction

Plug 'rbgrouleff/bclose.vim'
let g:bclose_no_plugin_maps = 1

" ========== DEFAULT+ =========
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'dylanaraps/root.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'machakann/vim-sandwich' " Surround replacment, with previews and stuff

Plug 'tpope/vim-vinegar'
Plug 'rickhowe/diffchar.vim'


" Plug 'unblevable/quick-scope' " Highlights the first unique character
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" Plug 'rhysd/clever-f.vim'
Plug 'justinmk/vim-sneak'
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

Plug 'markonm/traces.vim'
Plug 'Konfekt/FastFold'
Plug 'romainl/vim-qf' " Better Quickfix

Plug 'junegunn/vim-slash' " Better in buffer search
Plug 'christoomey/vim-tmux-navigator' " Makes <C-hjkl> work between windows from tmux
Plug 'benmills/vimux' " Send commands to tmux
Plug 'machakann/vim-swap'

Plug 'junegunn/vim-easy-align'
Plug 'andymass/vim-matchup'
let g:loaded_watchit = 1
let g:matchup_surround_enabled = 1
let g:matchup_transmute_enabled = 1
let g:matchup_matchparen_deferred = 1
let g:matchup_override_vimtex = 1


" Let's you preview the registers
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_delay = 50

Plug 'arp242/jumpy.vim' " Maps [[ and ]]

" Plug 'jeetsukumaran/vim-indentwise' " Motions based on indention


" ========== GIT ============
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'whiteinge/diffconflicts'


" === Because Emacs ===
Plug 'metakirby5/codi.vim'
" Discovering keys
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" let g:mapleader = "\<Space>"
" let g:maplocalleader = '\'
" nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
" vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
" nnoremap <silent> <localleader>      :<c-u>WhichKey '\'<CR>
" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 ruler


" ========== BECOMING AN IDE 101 =============
" Plug 'Shougo/echodoc.vim'
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'echo'

Plug 'liuchengxu/vista.vim'
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
      \ 'go': 'coc',
      \ 'javascript': 'coc',
      \ 'typescript': 'coc',
      \ 'javascript.jsx': 'coc',
      \ 'python': 'coc',
      \ }
let g:vista_fzf_preview = ['right:40%']
let g:vista_echo_cursor_strategy = 'echo'
let g:vista_sidebar_position='vertical topleft'
let g:vista_disable_statusline=1
let g:vista_highlight_whole_line=1
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

Plug 'kassio/neoterm'
Plug 'mbbill/undotree'
" Plug 'ludovicchabant/vim-gutentags'
" let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
" let g:gutentags_cache_dir = '/tmp/tags/'
" let g:gutentags_project_root = ['Makefile', 'makefile',
"             \'.git', 'readme.md', 'readme.txt']

" SNIPPETS
Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" let g:UltiSnipsExpandTriggerOrJump     = '<tab>'
" let g:UltiSnipsExpandTrigger     = '<tab>'
" let g:UltiSnipsJumpForwardTrigger      = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger     = '<S-tab>'


" THE LANGUAGE CLIENT + AUTOCOMPLETION
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}


" Action menu like all the cool kids
Plug 'kizza/actionmenu.nvim'
let s:code_actions = []

func! ActionMenuCodeActions() abort
    let s:code_actions = CocAction('codeActions')
    let l:menu_items = map(copy(s:code_actions), { index, item -> item['title'] })
    call actionmenu#open(l:menu_items,
                \'ActionMenuCodeActionsCallback')
endfunc
func! ActionMenuCodeActionsCallback(index, item) abort
    if a:index >= 0
        let l:selected_code_action = s:code_actions[a:index]
        let l:response = CocAction('doCodeAction', l:selected_code_action)
    endif
endfunc

nnoremap <silent> <M-CR> :call ActionMenuCodeActions()<CR>
xnoremap <silent> <M-CR> :call ActionMenuCodeActions()<CR>
inoremap <silent> <M-CR> <esc>:call ActionMenuCodeActions()<CR>i





" ======== WEIRD READING/WRITING STUFF ========
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
command! -nargs=0 ReadMode Goyo | set laststatus=0 showtabline=0 signcolumn=no showmode
command! -nargs=0 CodeMode Goyo! | set laststatus=2 showtabline=2 signcolumn=yes noshowmode

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

Plug 'vim-voom/VOoM'
let g:voom_return_key = "<M-Space>"
let g:voom_tab_key = "<M-tab>"
let g:voom_ft_modes = {'markdown': 'markdown', 'tex': 'latex'}


" ======== LATEX ========
Plug 'lervag/vimtex'
" TEX SETTINGS
let g:tex_flavor = "latex"
let g:tex_comment_nospell=1
let g:vimtex_latexmk_progname = 'nvr'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
if has('macunix')
  let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
  let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
  let g:vimtex_view_method = 'skim'
endif

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

" ======== MARKDOWN ========
" Plug 'gabrielelana/vim-markdown'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

if has('macunix')
    Plug 'junegunn/vim-xmark', { 'do': 'make' }
endif

" ======== GRAPHVIZ ========
Plug 'wannesm/wmgraphviz.vim'

" ======== TYPESCRIPT =======
Plug 'leafgarland/typescript-vim'

" ======== PYTHON =======
Plug 'tmhedberg/SimpylFold'

" ======== SWIFT ======
Plug 'keith/swift.vim'
Plug 'kentaroi/ultisnips-swift'

" ======= R =======
Plug 'jalvesaq/Nvim-R' " R IDE
Plug 'chrisbra/csv.vim'
" let R_in_buffer=0
" let R_notmuxconf=1
cnoreabbrev Rdoc Rhelp

" ======= OCAML ======
Plug 'ELLIOTTCABLE/vim-menhir'

" ======== GO ======
Plug 'arp242/gopher.vim'
let g:gopher_map = 0
let g:gopher_map = {'_nmap_prefix': '<localleader>', '_imap_prefix': '<C-g>'}
Plug 'sebdah/vim-delve'
" autocmd BufWritePre *.go :CocCommand editor.action.organizeImport
let g:delve_breakpoint_sign = '●'
let g:delve_breakpoint_sign_highlight = 'CocHintSign'
let g:delve_tracepoint_sign = '◆'
let g:delve_tracepoint_sign_highlight = 'CocWarningSign'


" Plug 'fatih/vim-go'
" " no mapping, we have CoC
" let g:go_code_completion_enabled = 0
" let g:go_def_mapping_enabled = 0
" let g:go_doc_keywordprg_enabled = 0
" "  more colors
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_types = 1
" let g:go_auto_sameids = 1
" let g:go_fmt_command = "goimports"

Plug 'vimwiki/vimwiki'

Plug 'cespare/vim-toml'

call plug#end()
