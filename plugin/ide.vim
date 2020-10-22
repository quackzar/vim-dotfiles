" IDE.vim
" ---------------
" Plugins and settings that relevant to running and writing code
" and give a IDE-like experience. And stuff that depends on LSP, etc.
"
" Basicly not langauge agnostic stuff but still general.
"

Plug 'skywind3000/asyncrun.vim'
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
let g:asyncrun_rootmarks = ['.git', '.svn', 'go.mod', '.root', '.project', '.hg']
let g:asyncrun_status = ''
let g:asyncrun_shell = '/bin/zsh'
let g:asyncrun_shellflag = '-c'
" let g:asyncrun_open = 6

Plug 'skywind3000/asynctasks.vim'
nnoremap <silent><f5> :AsyncTask file-build<cr>
nnoremap <silent><f9> :AsyncTask file-run<cr>
nnoremap <silent><f6> :AsyncTask project-build<cr>
nnoremap <silent><f7> :AsyncTask project-run<cr>
let g:asynctasks_term_pos = 'bottom'


Plug 'liuchengxu/vista.vim'
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:40%']
let g:vista_echo_cursor_strategy = 'echo'
let g:vista_sidebar_position='vertical topleft'
let g:vista_disable_statusline=1
let g:vista_highlight_whole_line=1
let g:vista_sidebar_keepalt=1

nnoremap <silent> <leader>v :Vista!!<cr>
nnoremap <silent> <leader>t :Vista finder coc<cr>
nnoremap <silent> <M-tab> :Vista focus<cr>

" THE LANGUAGE CLIENT + AUTOCOMPLETION
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'


if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <C-X><C-O> coc#refresh()


if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'

nmap <silent> <C-]> <Plug>(coc-definition)
autocmd FileType help nnoremap <buffer> <C-]> <C-]>

" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nnoremap <silent> <leader>C  :<C-u>CocList commands<cr>

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <leader>z :CocCommand explorer<CR>


command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 Pickcolor :call CocAction('pickColor')
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Changecolorrep :call CocAction('colorPresentation')

" Completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>


Plug 'romainl/vim-qf' " Better Quickfix
nmap \q <Plug>(qf_qf_toggle)
nmap <C-w><Space> <Plug>(qf_qf_switch)


Plug 'honza/vim-snippets'

Plug 'vim-voom/VOoM'
let g:voom_return_key = "<M-Space>"
let g:voom_tab_key = "<M-tab>"
let g:voom_ft_modes = {'markdown': 'markdown', 'tex': 'latex'}

Plug 'voldikss/vim-floaterm'
let g:floaterm_winblend = 25
let g:floaterm_keymap_toggle = '<F10>'
