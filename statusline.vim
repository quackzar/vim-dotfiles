function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, ' ' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, ' ' . info['warning'])
    endif
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

function! StatusGit()
    let l:s = fugitive#head()
    if l:s == ''
        return ''
    endif
    return ' ' . l:s . ' '
endfunction

function! VimTexStatus()
    let l:msg = ''
    let l:compiler = get(get(b:, 'vimtex', {}), 'compiler', {})
    if !empty(l:compiler)
        if has_key(l:compiler, 'is_running') && b:vimtex.compiler.is_running()
            if get(l:compiler, 'continuous')
                let l:msg .= ' '
            else
                let l:msg .= ' '
            endif
        endif
    endif
    return l:msg
endfunction

function! NearestMethodOrFunction() abort
    let l:msg = get(b:, 'vista_nearest_method_or_function', '')
    if empty(l:msg)
        return ' '
    else
        return ': ' . l:msg . ' '
    end
endfunction


function! StatusLine(current, width)
    let l:s = ''
    " LEFT SIDE
    if a:current " Current mode
        if &filetype=='voomtree'
            let l:s .= crystalline#mode_color() . ' VOOM ' . crystalline#right_mode_sep('')
            let l:s .= crystalline#right_sep('', 'Fill')
            return l:s
        end
        if &filetype=='vista_kind'
            let l:s .= crystalline#mode_color() . ' VISTA ' . crystalline#right_mode_sep('')
            let l:s .= crystalline#right_sep('', 'Fill')
            return l:s
        end
        let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
    else
        let l:s .= '%#CrystallineInactive#'
    endif
    let l:s .= ' %f%h%w'
                \. '%{&mod ? "  " : ""}'
                \. '%{&readonly ? "  " : ""}'
                \. ' '
    " Status and such
    if a:current
        let l:s .= crystalline#right_sep('', 'Fill')
                    \. ' %{StatusGit()} '
                    \. '%{StatusDiagnostic()}'
    endif
    let l:s .= '%=' " RIGHT SIDE
    if a:current
        let l:s .= '%{NearestMethodOrFunction()}'
        " Active options
        let l:s .= crystalline#left_sep('', 'Fill') . ' '
        let l:s .= '%{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
        let l:s .= '%{VimTexStatus()}'
    endif

    if a:current
        let l:s .= crystalline#left_mode_sep('')
    endif
    if a:width > 80 && &buftype != 'terminal'
        let l:s .= ' %{WebDevIconsGetFileTypeSymbol()}'
                    \. '[%{&enc}]'
                    \. ' %{WebDevIconsGetFileFormatSymbol()} %l/%L %c%V %P '
    else
        let l:s .= ' '
    endif
    return l:s
endfunction
function! TabLine()
    let l:str = substitute(getcwd(), $HOME, '~', 'g')
    return crystalline#bufferline(2, len(l:str)+2, 1)
                \. '%='.crystalline#left_sep('TabType','TabFill')
                \. l:str . ' '
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'molokai'

