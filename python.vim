" ======= Python stuff =======
hi pythonSelf  ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
set clipboard=unnamed
let python_highlight_all=1

filetype plugin indent on
  au FileType py set autoindent
  au FileType py set smartindent
  au FileType py set textwidth=79 " PEP-8 Friendly
autocmd BufWritePost *.py call Flake8()
let $PYTHONUNBUFFERED=1
map <F5> :AsyncRun -raw python3 %<CR>
noremap <F7> :AsyncRun gcc "%" -o "%<" <cr>
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
let g:pymode_python = 'python3'
