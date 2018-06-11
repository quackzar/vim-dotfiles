" ======= Bookmarks =======
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_no_default_key_mappings = 1


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
let g:ycm_autoclose_preview_window_after_completion=1

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
let ale_python_pylint_options='--max-line-length=120 --load-plugins pylint_django'
let ale_python_flake8_options='--max-line-length=120 --load-plugins pylint_django'
let g:ale_lint_on_enter=0
let g:ale_fixers = {}
let g:ale_fixers.tex = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.vim = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.python = ['autopep8', 'isort', 'yapf']
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

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

" ============= CtrlP ===============
let g:ctrlp_exentions = ['tag', 'buffertag', 'bookmarkdir']

