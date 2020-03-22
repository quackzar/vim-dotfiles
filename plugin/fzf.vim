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
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Special'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'Normal', 'Normal'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
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
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif
let $FZF_DEFAULT_OPTS=' --color=dark --layout=reverse'
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
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
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction


command! CmdHist call fzf#vim#command_history({'right': '40'})
nnoremap q: :CmdHist<CR>

command! QHist call fzf#vim#search_history({'right': '40'})
nnoremap q/ :QHist<CR>

Plug 'Shougo/neomru.vim'
Plug 'yuki-ycino/fzf-preview.vim'
let g:fzf_preview_command = 'bat --color=always --theme=ansi-dark --style=grid {-1}'
let g:fzf_preview_lines_command = 'bat --color=always --style=grid --theme=ansi-dark --plain'
let g:fzf_preview_use_dev_icons = 0
let g:fzf_preview_dev_icon_prefix_length = 1
let g:fzf_preview_filelist_postprocess_command = "" " 'xargs -d "\n" exa --color=always' " Use exa
let g:fzf_preview_filelist_command = 'rg --files --follow -no-messages --glob \!"* *"'

" See https://minsw.github.io/fzf-color-picker/
let g:fzf_preview_fzf_color_option = 'bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672'

command! Files FzfPreviewDirectoryFiles
command! Lines FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'"

" FZF
nnoremap <silent> <leader>f :FzfPreviewDirectoryFiles<CR>
nnoremap <silent> <leader>b :FzfPreviewBuffers<CR>
nnoremap <silent> <leader>p :FzfPreviewMruFiles<CR>

nmap <Leader>F [fzf-p]


nnoremap <silent> [fzf-p]p     :<C-u>FzfPreviewFromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>FzfPreviewGitStatus<CR>
nnoremap <silent> [fzf-p]b     :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>FzfPreviewAllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>FzfPreviewFromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>FzfPreviewJumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>FzfPreviewChanges<CR>
nnoremap <silent> [fzf-p]/     :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>FzfPreviewProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>FzfPreviewBufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>FzfPreviewQuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>FzfPreviewLocationList<CR>
