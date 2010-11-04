set expandtab
set sw=4
set sts=4

exe 'setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null\ \|\ sed\ -n\ \''2,\$p\''\ \|\ unexpand\ -t\ 2'
setlocal makeprg=xmllint\ --valid\ --noout\ % 
setlocal errorformat=%f:%l:\ %m
