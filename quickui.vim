" ========= Quick UI ========
let g:quickui_show_tip = 1
let g:quickui_border_style = 2

call quickui#menu#reset()
call quickui#menu#install('&File', [
            \ [ "&Open File\t␣f", 'Files' ],
            \ [ "&Close", 'close' ],
            \ [ "--", '' ],
            \ [ "&Save", 'wa'],
            \ [ "Save All", 'wa' ],
            \ [ "--", '' ],
            \ [ "E&xit", 'qa' ],
            \ ])
call quickui#menu#install('&Edit', [
            \ [ '&Find', 'echo 3', 'help 3' ],
            \ [ '&Align', 'EasyAlign', 'help easyalign'],
            \ ])
call quickui#menu#install("&Option", [
            \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
            \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
            \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
            \ ['Toggle &Lens', 'call lens#toggle()'],
            \ ['Toggle &Context', 'ContextToggle'],
            \ ['Toggle &Rainbows', 'RainbowParentheses!'],
            \ ])
call quickui#menu#install('&Build', [
            \ ["Build File\t F5", 'AsyncTask file-build'],
            \ ["Run File\t F9", 'AsyncTask file-run'],
            \ ['--',''],
            \ ["Build Project\t F6", 'AsyncTask project-build'],
            \ ["Run Project\t F7", 'AsyncTask project-run'],
            \ ["Run Tests", 'AsyncTask project-test'],
            \ ["Clean Project", 'AsyncTask project-clean'],
            \ ])
call quickui#menu#install('&Language Server', [
            \ ['&Format File', 'call CocAction("format")'],
            \ ['&Organize Imports', "call CocAction('runCommand', 'editor.action.organizeImport')"],
            \ ['&Dianogstics', 'CocList diagnostics'],
            \ ['&Extensions', 'CocList extensions'],
            \ ['&Outline', 'CocList outline'],
            \ ['&Symbols', 'CocList -I symbols']
            \ ])
call quickui#menu#install('H&elp', [
            \ ["&Cheatsheet", 'call quickui#tools#display_help("index")', ''],
            \ ['T&ips', 'call quickui#tools#display_help("tips")', ''],
            \ ['--',''],
            \ ["&Tutorial", 'call quickui#tools#display_help("tutor")', ''],
            \ ['&Quick Reference', 'call quickui#tools#display_help("quickref")', ''],
            \ ['&Summary', 'call quickui#tools#display_help("summary")', ''],
            \ ], 10000)

call quickui#menu#install('&LaTeX', [
            \ ['&Compile', 'VimtexCompile'],
            \ ['Compile &SS', 'VimtexCompileSS'],
            \ ['C&lean', 'VimtexClean'],
            \ ['Stop', 'VimtexStop'],
            \ ], '<auto>', 'tex,latex')

let content = [
            \ ["&Help Keyword\t\\ch", 'echo 100' ],
            \ ["&Signature\t\\cs", 'echo 101'],
            \ ['-'],
            \ ["Find in &File\t\\cx", 'echo 200' ],
            \ ["Find in &Project\t\\cp", 'echo 300' ],
            \ ["Find in &Defintion\t\\cd", 'echo 400' ],
            \ ["Search &References\t\\cr", 'echo 500'],
            \ ['-'],
            \ ["&Documentation\t\\cm", 'echo 600'],
            \ ]


let opts = {'index':g:quickui#context#cursor}
nnoremap <silent> <space>x :call quickui#context#open(content, opts)<cr>

augroup MyQuickfixPreview
  au!
  au FileType qf noremap <silent><buffer> p :call quickui#tools#preview_quickfix()<cr>
augroup END
