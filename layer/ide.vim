" IDE.vim
" ---------------
" Plugins and settings that relevant to running and writing code
" and give a IDE-like experience. And stuff that depends on LSP, etc.


" ============ Build/Run =========== {{{
Plug 'skywind3000/asyncrun.vim'
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
let g:asyncrun_rootmarks = ['.git', '.svn', 'go.mod', '.root', '.project', '.hg']
let g:asyncrun_status = ''
let g:asyncrun_shell = 'zsh'
let g:asyncrun_shellflag = '-c'
let g:asyncrun_open = 6
" augroup AsyncSpinner
"     autocmd User AsyncRunStart call luaeval("require'spinner'.start()")
"     autocmd User AsyncRunStop call luaeval("require'spinner'.stop()")
" augroup end
Plug 'skywind3000/asynctasks.vim'
nnoremap <silent><f5> :AsyncTask file-build<cr>
nnoremap <silent><f9> :AsyncTask file-run<cr>
nnoremap <silent><f6> :AsyncTask project-build<cr>
nnoremap <silent><f7> :AsyncTask project-run<cr>
command! Run AsyncTask file-run
let g:asynctasks_term_pos = 'bottom'

" }}}

" ========== Language Server ========== {{{

" Note: coc.nvim is in a seperate file.

" Native LSP -- should probably use this one, but setup is annoying right now
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'weilbith/nvim-code-action-menu'
Plug 'kosayoda/nvim-lightbulb'
autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
Plug 'nvim-lua/lsp-status.nvim'
Plug 'folke/trouble.nvim'
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
Plug 'ray-x/lsp_signature.nvim'
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'filipdutescu/renamer.nvim', { 'branch': 'master' }



" COQ -- Pretty cool
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
let g:coq_settings = {
    \ 'auto_start': 'shut-up',
    \ 'display': {
        \ 'pum': {
            \ 'fast_close': v:false
        \ }
    \},
    \ 'display.icons.mappings': {
        \ "Class":         " ",
        \ "Color":         " ",
        \ "Constant":      " ",
        \ "Constructor":   " ",
        \ "Enum":          " ",
        \ "EnumMember":    " ",
        \ "Event":         " ",
        \ "Field":         " ",
        \ "File":          " ",
        \ "Folder":        " ",
        \ "Function":      " ",
        \ "Interface":     " ",
        \ "Keyword":       " ",
        \ "Method":        " ",
        \ "Module":        " ",
        \ "Operator":      " ",
        \ "Property":      " ",
        \ "Reference":     " ",
        \ "Snippet":       " ",
        \ "Struct":        " ",
        \ "Text":          " ",
        \ "TypeParameter": " ",
        \ "Unit":          " ",
        \ "Value":         " ",
        \ "Variable":      " ",
        \ } }

Plug 'github/copilot.vim'
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Plug 'liuchengxu/vista.vi fm'
" let g:vista#renderer#enable_icon = 1
" let g:vista_fzf_preview = ['right:40%']
" let g:vista_echo_cursor_strategy = 'echo'
" let g:vista_sidebar_position='vertical topleft'
" let g:vista_disable_statusline=1
" let g:vista_highlight_whole_line=1
" let g:vista_sidebar_keepalt=1

" nnoremap <silent> <leader>v :Vista!!<cr>
" nnoremap <silent> <leader>t :Vista finder coc<cr>
" nnoremap <silent> <M-tab> :Vista focus<cr>

Plug 'honza/vim-snippets'


" }}}
" ========= Testing ========= {{{
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"
let test#strategy = {
  \ 'nearest': 'asyncrun',
  \ 'file':    'asyncrun_background',
  \ 'suite':   'asyncrun',
\}
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
" }}}

let g:ultest_use_pty = 1
nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)

" =========== Debugging =========== {{{
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'Pocco81/DAPInstall.nvim'

Plug 'mfussenegger/nvim-dap-python'


au FileType dap-repl lua require('dap.ext.autocompl').attach()


nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>

nnoremap <silent> <leader>du :lua require("dapui").toggle()<CR>

"}}}


Plug 'voldikss/vim-floaterm'
let g:floaterm_winblend = 25
let g:floaterm_keymap_toggle = '<F10>'

" vim: foldmethod=marker
