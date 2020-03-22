function! CycleNumbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!<CR>
  endif
endfunction

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

function! WrapToggle()
    if &wrap == 0
        echo "Wrap ON"
        setlocal wrap
    else
        echo "Wrap OFF"
        setlocal nowrap
    endif
endfunction

function! ToggleSignColumn()
    if &signcolumn=='no'
        echo 'Signcolumn AUTO'
        set signcolumn=auto:1
    else
        echo 'Signcolumn OFF'
        set signcolumn=no
    endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! Evaluate_ftplugin_path()
    return stdpath('config') . "/ftplugin/" . &filetype . ".vim"
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Toggles
nnoremap <silent> <Leader>k :call ToggleSpellCheck()<CR>
nnoremap <silent> <leader>l :call CycleNumbering()<cr>
nnoremap <silent> <leader>c :call ConcealToggle()<cr>
nnoremap <silent> <leader>u :call WrapToggle()<cr>
nnoremap <silent> <Leader>ef :tabe <C-r>=Evaluate_ftplugin_path()<CR><CR>
