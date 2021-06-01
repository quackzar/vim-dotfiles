" FZF.vim
" -----------
" Stuff relevant to fzf.
"
if has('macos')
    Plug '/usr/local/opt/fzf'
else
    Plug 'junegunn/fzf'
end
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

let g:fzf_colors =
    \ { 'fg':      ['fg', 'Comment'],
      \ 'bg':      ['bg', 'Floating'],
      \ 'hl':      ['fg', 'Special'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'Floating', 'Floating'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Floating'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Tag'],
      \ 'spinner': ['fg', 'Label'],
      \ 'gutter':  ['fg', 'Conceal'],
      \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

let g:fzf_buffers_jump = 1
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" ripgrep
" no hidden stuff, ignore the .git directory
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep\ -g='!*.pdf'\ -g='!*.eps'
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif
let $FZF_DEFAULT_OPTS=' --color=dark --layout=reverse'
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.8)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {
                \'relative': 'editor',
                \'row': top,
                \'col': left,
                \'width': width,
                \'height': height,
                \'style': 'minimal'
                \}
    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

command! CmdHist call fzf#vim#command_history({'right': '40'})
" nnoremap q: :CmdHist<CR>

command! QHist call fzf#vim#search_history({'right': '40'})
" nnoremap q/ :QHist<CR>

Plug 'Shougo/neomru.vim'
" Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }

" command! Files FzfPreviewDirectoryFiles
" command! Buffers FzfPreviewBuffers
" let g:fzf_preview_use_dev_icons = 1
" let g:fzf_preview_fzf_color_option = 'bg+:#293739,'
"             \. 'bg:#1B1D1E,'
"             \. 'border:#808080,'
"             \. 'spinner:#E6DB74,'
"             \. 'hl:#7E8E91,'
"             \. 'fg:#F8F8F2,'
"             \. 'header:#7E8E91,'
"             \. 'info:#A6E22E,'
"             \. 'pointer:#af87ff,'
"             \. 'marker:#62D8F1,'
"             \. 'fg+:#F8F8F2,'
"             \. 'prompt:#62D8F1,'
"             \. 'hl+:#F92672'

" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>p :FZFMru<CR>

function! s:fzf_sink(what)
    let p1 = stridx(a:what, '<')
    if p1 >= 0
        let name = strpart(a:what, 0, p1)
        let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
        if name != ''
            exec "AsyncTask ". fnameescape(name)
        endif
    endif
endfunction

function! s:fzf_task()
    let rows = asynctasks#source(&columns * 48 / 100)
    let source = []
    for row in rows
        let name = row[0]
        let source += [name . '  ' . row[1] . '  : ' . row[2]]
    endfor
    let opts = { 'source': source, 'sink': function('s:fzf_sink'),
                \ 'options': '+m --nth 1 --inline-info --tac' }
    if exists('g:fzf_layout')
        for key in keys(g:fzf_layout)
            let opts[key] = deepcopy(g:fzf_layout[key])
        endfor
    endif
    call fzf#run(opts)
endfunction

command! -nargs=0 Tasks call s:fzf_task()
