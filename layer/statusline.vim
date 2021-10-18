" Plug 'glepnir/galaxyline.nvim'
Plug 'windwp/windline.nvim'


Plug 'romgrk/barbar.nvim'
" Magic buffer-picking mode
nnoremap <silent> <C-s> :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>Bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>Bl :BufferOrderByLanguage<CR>
" Move to previous/next
nnoremap <silent>    <space>, :BufferPrevious<CR>
nnoremap <silent>    <space>. :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <space>< :BufferMovePrevious<CR>
nnoremap <silent>    <space>> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>   <space>1 :BufferGoto 1<CR>
nnoremap <silent>   <space>2 :BufferGoto 2<CR>
nnoremap <silent>   <space>3 :BufferGoto 3<CR>
nnoremap <silent>   <space>4 :BufferGoto 4<CR>
nnoremap <silent>   <space>5 :BufferGoto 5<CR>
nnoremap <silent>   <space>6 :BufferGoto 6<CR>
nnoremap <silent>   <space>7 :BufferGoto 7<CR>
nnoremap <silent>   <space>8 :BufferGoto 8<CR>
nnoremap <silent>   <space>9 :BufferLast<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
