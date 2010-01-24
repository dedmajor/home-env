set path+=/opt/sun-jdk-1.6.0.16/src/
map <F7> :!ctags -R -f ./tags --languages=Java --Java-kinds=cimp --tag-relative=yes ./ /opt/sun-jdk-1.6.0.16/src/ --exclude="\.svn" --totals=yes<cr>


