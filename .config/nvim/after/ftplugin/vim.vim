setlocal tabstop=2
setlocal expandtab
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal fileformat=unix
setlocal textwidth=120

nnoremap <silent><buffer> [[ m':call search('^\s*\(fu\%[nction]\\|def\)\>', "bW")<CR>
vnoremap <silent><buffer> [[ m':<C-U>exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|def\)\>', "bW")<CR>
nnoremap <silent><buffer> ]] m':call search('^\s*\(fu\%[nction]\\|def\)\>', "W")<CR>
vnoremap <silent><buffer> ]] m':<C-U>exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|def\)\>', "W")<CR>
nnoremap <silent><buffer> [] m':call search('^\s*end\(f\%[unction]\\|def\)\>', "bW")<CR>
vnoremap <silent><buffer> [] m':<C-U>exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|def\)\>', "bW")<CR>
nnoremap <silent><buffer> ][ m':call search('^\s*end\(f\%[unction]\\|def\)\>', "W")<CR>
vnoremap <silent><buffer> ][ m':<C-U>exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|def\)\>', "W")<CR>
