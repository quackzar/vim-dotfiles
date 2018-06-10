" =========== NERDTree ==============
if ! has('gui_vimr')
  map <F3> :NERDTreeToggle<CR>
  autocmd FileType nerdtree setlocal nolist
  let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  let g:NERDTreeDirArrowExpandable = '>'
  let g:NERDTreeDirArrowCollapsible = 'v'
  let g:root#patterns = ['.git', 'tags']
  let NERDTreeIgnore = ['\.DAT$', '\.LOG1$', '\.LOG1$', '.pyc$', '\~$']
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
  " NERDTree Fix
  function! BookmarkMapKeys()
      nmap mm :BookmarkToggle<CR>
      nmap mi :BookmarkAnnotate<CR>
      nmap mn :BookmarkNext<CR>
      nmap mp :BookmarkPrev<CR>
      nmap ma :BookmarkShowAll<CR>
      nmap mc :BookmarkClear<CR>
      nmap mx :BookmarkClearAll<CR>
      nmap mkk :BookmarkMoveUp
      nmap mjj :BookmarkMoveDown
  endfunction
  function! BookmarkUnmapKeys()
      unmap mm
      unmap mi
      unmap mn
      unmap mp
      unmap ma
      unmap mc
      unmap mx
      unmap mkk
      unmap mjj
  endfunction
  autocmd BufEnter * :call BookmarkMapKeys()
  autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()
  let g:airline#extensions#tabline#enabled = 1
endif
