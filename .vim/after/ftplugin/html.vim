" http://www.vim.org/tips/tip.php?tip_id=18
setlocal makeprg=tidy\ -quiet\ -errors\ -m\ -utf8\ %
setlocal errorformat=line\ %l\ column\ %v\ -\ %m
exe 'setlocal equalprg=tidy\ -wrap\ 100\ -quiet\ -i\ --show-body-only\ true\ -utf8\ -f\ /dev/null\ \|\ unexpand\ -t\ 2'