" IDE.vim
" ---------------
" Plugins and settings that relevant to running and writing code
" and give a IDE-like experience. And stuff that depends on LSP, etc.
"
" Basicly not langauge agnostic stuff but still general.
"

Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
nnoremap <silent><f5> :AsyncTask file-run<cr>
nnoremap <silent><f9> :AsyncTask file-build<cr>
nnoremap <silent><f6> :AsyncTask project-build<cr>
nnoremap <silent><f7> :AsyncTask project-run<cr>
let g:asyncrun_rootmarks = ['.git', '.svn', 'go.mod', '.root', '.project', '.hg']
let g:asynctasks_term_pos = 'bottom'
let g:asynctasks_system = 'macos'

Plug 'liuchengxu/vista.vim'
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:40%']
let g:vista_echo_cursor_strategy = 'echo'
let g:vista_sidebar_position='vertical topleft'
let g:vista_disable_statusline=1
let g:vista_highlight_whole_line=1

nnoremap <silent> <leader>v :Vista!!<cr>
nnoremap <silent> <leader>t :Vista finder coc<cr>
nnoremap <silent> <M-tab> :Vista focus<cr>

" THE LANGUAGE CLIENT + AUTOCOMPLETION
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'antoinemadec/coc-fzf'

" inoremap <silent><expr> <M-space> 
"             \pumvisible() ? "\<C-y>" : coc#refresh()
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <C-X><C-O> coc#refresh()

let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'

nmap <silent> <C-]> <Plug>(coc-definition)
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nnoremap <silent> <leader>C  :<C-u>CocList commands<cr>

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>? <Plug>(coc-diagnostic-info)

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        " call quickui#tools#display_help(expand('<cword>'))
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <leader>z :CocCommand explorer<CR>


command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 Pickcolor :call CocAction('pickColor')
command! -nargs=0 Changecolorrep :call CocAction('colorPresentation')
command! -bar -nargs=0 Config tabnew|
            \exe 'tcd '.g:rootDirectory|
            \exe 'e '  .g:rootDirectory . 'plugins.vim'|
            \exe 'e '  .g:rootDirectory . 'init.vim'

" Completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Plug 'axvr/zepl.vim'
" augroup zepl
"     autocmd!
"     autocmd FileType python     let b:repl_config = { 'cmd': 'python3' }
"     autocmd FileType javascript let b:repl_config = { 'cmd': 'node' }
"     autocmd FileType clojure    let b:repl_config = { 'cmd': 'clj' }
"     autocmd FileType scheme     let b:repl_config = { 'cmd': 'rlwrap csi' }
"     autocmd FileType lisp       let b:repl_config = { 'cmd': 'sbcl' }
"     autocmd FileType julia      let b:repl_config = { 'cmd': 'julia' }
" augroup END


Plug 'romainl/vim-qf' " Better Quickfix
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0
nnoremap \q <Plug>(qf_qf_toggle)

" SNIPPETS
Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" let g:UltiSnipsExpandTriggerOrJump     = '<tab>'
" let g:UltiSnipsExpandTrigger     = '<tab>'
" let g:UltiSnipsJumpForwardTrigger      = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger     = '<S-tab>'
"

Plug 'vim-voom/VOoM'
let g:voom_return_key = "<M-Space>"
let g:voom_tab_key = "<M-tab>"
let g:voom_ft_modes = {'markdown': 'markdown', 'tex': 'latex'}
