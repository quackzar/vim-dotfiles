
" ====== LaTeX =======
let g:tex_flavor = "latex"
let g:tex_comment_nospell=1

set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()

if has('nvim')
    let g:vimtex_compiler_progname = 'nvr'
endif

if has('macunix')
  let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
  let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
elseif has('win32')
  let g:vimtex_view_general_viewer = 'C:/PROGRA~1/SumatraPDF/SumatraPDF.exe'
  let g:vimtex_view_general_options
      \ = ' -forward-search @tex @line @pdf'
      \ . ' -inverse-search "gvim --servername ' . v:servername
      \ . ' --remote-send \"^<C-\^>^<C-n^>'
      \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
      \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
      \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
      \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

autocmd FileType tex,plaintex let b:switch_custom_definitions =
    \ [
    \    [ '\\tiny', '\\scriptsize', '\\footnotesize', '\\small', '\\normalsize', '\\large', '\\Large', '\\LARGE', '\\huge', '\\Huge' ],
    \    [ '\\displaystyle', '\\scriptstyle', '\\scriptscriptstyle', '\\textstyle' ],
    \    [ '\\part', '\\chapter', '\\section', '\\subsection', '\\subsubsection', '\\paragraph', '\\subparagraph' ],
    \    [ 'part:', 'chap:', 'sec:', 'subsec:', 'subsubsec:' ],
    \    [ 'article', 'report', 'book', 'letter', 'slides' ],
    \    [ 'a4paper', 'a5paper', 'b5paper', 'executivepaper', 'legalpaper', 'letterpaper', 'beamer', 'subfiles', 'standalone' ],
    \    [ 'onecolumn', 'twocolumn' ],
    \    [ 'oneside', 'twoside' ],
    \    [ 'draft', 'final' ],
    \    [ 'AnnArbor', 'Antibes', 'Bergen', 'Berkeley',
    \      'Berlin', 'Boadilla', 'CambridgeUS', 'Copenhagen', 'Darmstadt',
    \      'Dresden', 'Frankfurt', 'Goettingen', 'Hannover', 'Ilmenau',
    \      'JuanLesPins', 'Luebeck', 'Madrid', 'Malmoe', 'Marburg',
    \      'Montpellier', 'PaloAlto', 'Pittsburgh', 'Rochester', 'Singapore',
    \      'Szeged', 'Warsaw' ]
    \ ]

