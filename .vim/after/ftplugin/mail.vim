
setl nonu

set foldmethod=expr
set foldexpr=strlen(substitute(substitute(getline(v:lnum),'\\s','',\"g\"),'[^>].*','',''))
set foldlevel=1
set foldenable

" auto format all
"setl fo+=a


" Tip: Place the cursor in the optimal position, editing email messages.
" http://vim.wikia.com/wiki/Automatically_position_the_cursor_when_editing_email_messages
" Function used to identify where to place the cursor, editing an email.
function! FirstInPost (...) range
  let cur = a:firstline
  while cur <= a:lastline
    let str = getline(cur)
    " Found an _empty_ subject in the headers.
    " NOTE: you can put similar checks to handle other empty headers
    " like To, From, Newgroups, ...
    if str == 'Subject: '
      execute cur
      ":start!
      break
    endif
    " We have reached the end of the headers.
    if str == ''
      let cur = cur + 1
      " If the first line of the body is an attribution, put
      " the cursor _after_ that line, otherwise the cursor is
      " leaved right after the headers (assuming we're writing
      " a new mail, and not editing a reply).
      " NOTE: modify the regexp to match your mail client's attribution!
      if strlen(matchstr(getline(cur), '^On.*wrote:.*')) > 0
        let cur = cur + 1
      endif
      execute cur
      ":start
      break
    endif
    let cur = cur + 1
  endwhile
endfunction
" Command to be called.
com! Fip :set tw=0<Bar>:%call FirstInPost()

" FIXME: doesn't work?
au BufRead,BufNew mutt* :Fip


