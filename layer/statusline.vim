" Plug 'glepnir/galaxyline.nvim'
Plug 'windwp/windline.nvim'


if has("nvim-0.5")
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
else
    Plug 'mengelbrecht/lightline-bufferline'
    " Tabline
    " let g:lightline#bufferline#read_only = ''
    let g:lightline#bufferline#unicode_symbols = 1
    let g:lightline#bufferline#unnamed = ' '
    let g:lightline#bufferline#min_buffer_count = 2

    let g:lightline#bufferline#number_map = {
                \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
                \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
                \ }
    let g:lightline#bufferline#enable_devicons = 1


    let g:lightline#bufferline#show_number = 2
    nmap <space>1 <Plug>lightline#bufferline#go(1)
    nmap <space>2 <Plug>lightline#bufferline#go(2)
    nmap <space>3 <Plug>lightline#bufferline#go(3)
    nmap <space>4 <Plug>lightline#bufferline#go(4)
    nmap <space>5 <Plug>lightline#bufferline#go(5)
    nmap <space>6 <Plug>lightline#bufferline#go(6)
    nmap <space>7 <Plug>lightline#bufferline#go(7)
    nmap <space>8 <Plug>lightline#bufferline#go(8)
    nmap <space>9 <Plug>lightline#bufferline#go(9)
    nmap <space>0 <Plug>lightline#bufferline#go(10)
end
