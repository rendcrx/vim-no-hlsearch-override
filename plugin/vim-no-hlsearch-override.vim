let s:restore_hlsearch = ""

function! s:cmd_enter()
    let s:restore_hlsearch = getreg('/')
endfunction

function! s:cmd_leave()
  let s:cmd = trim(getcmdline())
  if s:cmd =~# '\v^s>'
    call timer_start(0, {-> s:restore()})
  endif
endfunction

function! s:restore()
  call setreg('/', s:restore_hlsearch)
endfunction

augroup vim-no-hlsearch-override-augroup
  autocmd!
  autocmd CmdlineEnter : call s:cmd_enter()
  autocmd CmdlineLeave : call s:cmd_leave()
augroup END
