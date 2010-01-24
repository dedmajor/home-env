set lines=60
set columns=180

" from vimperator tips and tricks
let g:netrw_http_cmd = "wget -q -O"

" FIXME: does not work with eclim
au BufRead vimperator* set columns=50
au BufRead vimperator* set lines=20

hi Cursor		guibg=#cccccc guifg=#cccccc
hi lCursor		guibg=green
hi cursorline	guibg=#333333
hi CursorColumn	guibg=#333333

"set lines=60
"set columns=140

" edit ~/.fonts.conf to append a fallback font family for unsupported charsets
set gfn=Dina\ 12

"Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff
