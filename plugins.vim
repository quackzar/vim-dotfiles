" This file should contain all plugins and their configurations.
" Keymaps may be omitted.
call plug#begin(g:rootDirectory . 'plugged/')

" ========= PURE EYE-CANDY =========

" Choose one
Plug 'rbong/vim-crystalline'
" exec 'source ' . g:rootDirectory . 'statusline.vim'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
exec 'source ' . g:rootDirectory . 'lightline.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'mhinz/vim-startify'
let g:startify_session_dir = g:rootDirectory . 'session/'
let g:startify_bookmarks = ['~/.config/nvim/init.vim', '~/.zshrc']
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
let g:startify_update_oldfiles = 1
autocmd User Startified nmap <buffer> <space><space><space> <plug>(startify-open-buffers)
autocmd User Startified nmap <buffer> <cr> :
autocmd User Startified setlocal cursorline buflisted
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
Plug 'skywind3000/vim-quickui'
let g:quickui_border_style = 2

let g:quickui_show_tip = 1
noremap <silent> <C-q> :call quickui#menu#open()<cr>


" ========== FZF & File Navigation ============
Plug '/usr/local/opt/fzf'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Comment'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Special'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'Normal', 'Normal'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Tag'],
      \ 'spinner': ['fg', 'Label'],
      \ 'gutter':  ['fg', 'Conceal'],
      \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

let g:fzf_buffers_jump = 1

" no hidden stuff, ignore the .git directory
let $FZF_DEFAULT_COMMAND = 'rg --files --follow --glob "!.git/*"'


let $FZF_DEFAULT_OPTS=' --color=dark --layout=reverse'
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {
                \'relative': 'editor',
                \'row': top,
                \'col': left,
                \'width': width,
                \'height': height,
                \'style': 'minimal'
                \}
    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

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

Plug 'Konfekt/FastFold'

" Plug 'unblevable/quick-scope' " Highlights the first unique character
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" Plug 'rhysd/clever-f.vim'
Plug 'justinmk/vim-sneak'
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
let g:sneak#label = 1
map <C-S> <Plug>Sneak_s



Plug 'psliwka/vim-smoothie'

Plug 'lambdalisue/suda.vim'

Plug 'markonm/traces.vim'
Plug 'junegunn/vim-slash' " Better in buffer search

Plug 'romainl/vim-qf' " Better Quickfix

Plug 'machakann/vim-swap'

" Errors in floating windows!
Plug 'wsdjeg/notifications.vim'

" Tmux and such
Plug 'christoomey/vim-tmux-navigator' " Makes <C-hjkl> work between windows from tmux
Plug 'benmills/vimux' " Send commands to tmux

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
" Let's you preview marks!
Plug 'Yilin-Yang/vim-markbar'
nmap <space>m  <Plug>ToggleMarkbar
let g:markbar_jump_to_mark_mapping  = 'G'
let g:markbar_num_lines_context = 3
let g:markbar_file_mark_format_string = '%s (%d, %d)'
let g:markbar_file_mark_arguments = ['fname', 'col', 'line']
hi link markbarContext String

Plug 'arp242/jumpy.vim' " Maps [[ and ]]

" ========== GIT ============
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'whiteinge/diffconflicts'


" ========== BECOMING AN IDE 101 =============
" Plug 'Shougo/echodoc.vim'
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'echo'

" Weird thing
Plug 'wellle/context.vim'
let g:context_enabled = 0

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
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

Plug 'mbbill/undotree'


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

" ====== LLVM ====
Plug 'rhysd/vim-llvm'

" ======== GO ======
Plug 'arp242/gopher.vim'
let g:gopher_map = 0
let g:gopher_map = {'_nmap_prefix': '<localleader>', '_imap_prefix': '<C-g>'}
Plug 'sebdah/vim-delve'
let g:delve_breakpoint_sign = '●'
let g:delve_breakpoint_sign_highlight = 'CocHintSign'
let g:delve_tracepoint_sign = '◆'
let g:delve_tracepoint_sign_highlight = 'CocWarningSign'

Plug 'vimwiki/vimwiki'

Plug 'cespare/vim-toml'

call plug#end()


" ========= Quick UI ========
" Currently filled with dummy items
call quickui#menu#reset()
call quickui#menu#install('&File', [
            \ [ "&New File\tCtrl+n", 'echo 0' ],
            \ [ "&Open File\t(F3)", 'echo 1' ],
            \ [ "&Close", 'echo 2' ],
            \ [ "--", '' ],
            \ [ "&Save\tCtrl+s", 'echo 3'],
            \ [ "Save &As", 'echo 4' ],
            \ [ "Save All", 'echo 5' ],
            \ [ "--", '' ],
            \ [ "E&xit\tAlt+x", 'echo 6' ],
            \ ])
call quickui#menu#install('&Edit', [
            \ [ '&Copy', 'echo 1', 'help 1' ],
            \ [ '&Paste', 'echo 2', 'help 2' ],
            \ [ '&Find', 'echo 3', 'help 3' ],
            \ ])
call quickui#menu#install("&Option", [
            \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
            \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
            \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
            \ ])
call quickui#menu#install('H&elp', [
            \ ["&Cheatsheet", 'help index', ''],
            \ ['T&ips', 'help tips', ''],
            \ ['--',''],
            \ ["&Tutorial", 'help tutor', ''],
            \ ['&Quick Reference', 'help quickref', ''],
            \ ['&Summary', 'help summary', ''],
            \ ], 10000)
