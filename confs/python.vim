" Vim filetype plugin file
" Language:	python

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
let b:delimitMate_expand_cr = 1
let b:delimitMate_nesting_quotes = ['"',"'"]

setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4 autoindent
setlocal nowrap

setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal include=\s*\\(from\\\|import\\)
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal suffixesadd=.py
setlocal comments-=:%
setlocal commentstring=#%s

setlocal omnifunc=pythoncomplete#Complete

nnoremap <silent> <buffer> ]] :call <SID>Python_jump('/^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [[ :call <SID>Python_jump('?^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> ]m :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [m :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>

if exists('*<SID>Python_jump') | finish | endif

fun! <SID>Python_jump(motion) range
    let cnt = v:count1
    let save = @/    " save last search pattern
    mark '
    while cnt > 0
	silent! exe a:motion
	let cnt = cnt - 1
    endwhile
    call histdel('/', -1)
    let @/ = save    " restore last search pattern
endfun


nnoremap <buffer> <leader>r :w<CR>:!/usr/bin/env python3 %<CR>
nnoremap <buffer> <leader>r2 :w<CR>:!/usr/bin/env python2 %<CR>