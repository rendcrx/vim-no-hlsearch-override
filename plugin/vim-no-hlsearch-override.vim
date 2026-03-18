if exists("g:loaded_vim_no_hlsearch_override")
  finish
endif
let g:loaded_vim_no_hlsearch_override = 1

let s:restore_hlsearch_content = ""
let s:restore_hlsearch_state = ""

function! s:cmd_enter()
  let s:restore_hlsearch_content = getreg('/')
  let s:restore_hlsearch_state = v:hlsearch
endfunction

function! s:cmd_leave()
  let l:cmd = trim(getcmdline())
  if l:cmd =~# '\v^s>'
    call timer_start(0, {-> s:restore()})
  endif
endfunction

function! s:restore()
  call setreg('/', s:restore_hlsearch_content)
  if !s:restore_hlsearch_state
    call timer_start(0, {-> execute("nohlsearch| redraw!")})
  endif
endfunction

augroup vim-no-hlsearch-override-augroup
  autocmd!
  autocmd CmdlineEnter : call s:cmd_enter()
  autocmd CmdlineLeave : call s:cmd_leave()
augroup END
