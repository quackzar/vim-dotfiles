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
            \ [ '&Symbols', 'Vista finder', 'help vista' ],
            \ [ '&Vista', 'Vista!!', 'help vista' ],
            \ [ '&Align', 'EasyAlign', 'help easyalign'],
            \ [ '&Edit Snippets', 'UltiSnipsEdit', 'help ultisnips'],
            \ ])
call quickui#menu#install("&Option", [
            \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
            \ ['Set C&ursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
            \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
            \ ['Set &Relative %{&relativenumber? "Off":"On"}', 'set relativenumber!'],
            \ ['Set &Numbers %{&number? "Off":"On"}', 'set number!'],
            \ ['Set &Wrap %{&wrap? "Off":"On"}', 'set wrap!'],
            \ ['Set S&igncolumn %{&signcolumn=="no"? "On":"Off"}',
            \   'call ToggleSignColumn()'],
            \ ['--',''],
            \ ['Toggle &Conceal', 'call ConcealToggle()'],
            \ ['Toggle L&ens', 'call lens#toggle()'],
            \ ['Toggle Con&text', 'ContextToggle'],
            \ ['Toggle R&ainbows', 'RainbowParentheses!'],
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
            \ ['&Organize Imports', "call CocAction('runCommand', 'editor.actnteriion.organizeImport')"],
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

call quickui#menu#install('La&TeX', [
            \ ['&Compile', 'VimtexCompile'],
            \ ['Compile &SS', 'VimtexCompileSS'],
            \ ['C&lean', 'VimtexClean'],
            \ ['Stop', 'VimtexStop'],
            \ ], '<auto>', 'tex,latex,bib')

call quickui#menu#install('&Version Control', [
            \ ['&Status', 'Gstatus'],
            \ ['&Add File', 'Gw'],
            \ ['&Commit', 'Gcommit'],
            \ ['P&ush', 'Gpush'],
            \ ['&Pull', 'Gpull'],
            \ ['Pull &Fast', 'Gupdate'],
            \ ])



let content = [
            \ ["&Help Keyword", "call quickui#tools#display_help(expand('<cword>'))" ],
            \ ["&Signature", "call CocAction('doHover')"],
            \ ["--", "--"],
            \ ["&Actions", "CocCommand actions.open" ],
            \ ["&Rename", "call CocAction('rename')"],
            \ ]


let opts = {'index':g:quickui#context#cursor}
nnoremap <silent> gK :call quickui#context#open(content, opts)<cr>

augroup MyQuickfixPreview
  au!
  au FileType qf noremap <silent><buffer> K :call quickui#tools#preview_quickfix()<cr>
augroup END
