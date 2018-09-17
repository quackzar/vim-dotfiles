if has('nvim')
    set inccommand=nosplit
endif

" ======= TSV & CSV =======
autocmd Filetype tsv setlocal noexpandtab, shiftwidth=20
            \, softtabstop=20, tabstop=20

autocmd Filetype .vim setlocal tw=0

" ======= Python stuff =======
hi pythonSelf  ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
set clipboard=unnamed
let python_highlight_all=1

filetype plugin indent on
  au FileType py set autoindent
  au FileType py set smartindent
  au FileType py set textwidth=79 " PEP-8 Friendly
let $PYTHONUNBUFFERED=1

" ======= Surround =======
let b:surround_{char2nr('e')}
      \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
let b:surround_{char2nr('c')} = "\\\1command: \1{\r}"

" ====== Switch relative numbers =======
set showcmd
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" ===== Toggle spellchecking ======
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

" ===== Auto-pairs =====
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutBackInsert=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
set diffopt=vertical
let g:gitgutter_diff_args = '-w'

" ============ ALE ===========
" let ale_python_pylint_options='--max-line-length=120 --load-plugins pylint_django'
" let ale_python_flake8_options='--max-line-length=120 --load-plugins pylint_django'
" let g:ale_lint_on_enter=0
" let g:ale_fixers = {}
" let g:ale_fixers.tex = ['remove_trailing_lines', 'trim_whitespace']
" let g:ale_fixers.vim = ['remove_trailing_lines', 'trim_whitespace']
" let g:ale_fixers.python = ['autopep8', 'isort', 'yapf']
" let g:ale_sign_error = ''
" let g:ale_sign_warning = ''

" ====== Snippets and Completion ======
set runtimepath+=~/.vim/custom_snips/
let g:UltiSnipsSnippetsDir = '~/.vim/custom_snips/UltiSnips'

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
