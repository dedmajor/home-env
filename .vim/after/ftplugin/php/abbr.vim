map <F7> :!ctags -R -f ./tags --languages=PHP --tag-relative=yes --PHP-kinds=cfid ./ /var/www/libs/oemlib-dev/ /var/www/libs/onphp-dev/ --exclude="\.svn" --totals=yes<cr>

iab eol PHP_EOL

" todo: use logging
" dbg(
iab dbg echo '<pre>';print_r);echo '<'.'/pre>';<C-O>F)
" ddbg(
iab ddbg echo '<pre>';print_r);echo '<'.'/pre>';die();<C-O>2F)

iab tm echo 'Test message in file: '.__FILE__.', on line: '.__LINE__;

" ClassName.class.php
iab xclass <c-r>=expand("%:t:r:r")<cr>

iab xret /**<cr>@return xclass<c-]><cr>/

iab xcreate public static function create()<cr>{<cr>return new self;<cr>}

iab sdbg echo '<pre>';print_r->toDialectString(PostgresDialect::me()));echo '<'.'/pre>';die();<C-O>F-

let b:phpSetGetTemplate = 
	\ "public function setPlaceHolder($placeHolder)\n" .
	\ "{\n" .
	\ "$this->placeHolder = $placeHolder;\n" .
	\ "\n" .
	\ "return $this;\n" .
	\ "}\n" .
	\ "\n" .
	\ "public function getPlaceHolder()\n" .
	\ "{\n" .
	\ "return $this->placeHolder;\n" .
	\ "}"

map <leader>sg diwS<C-R>=b:phpSetGetTemplate<cr><esc>
	\v{{{:s/placeHolder/\=SmartCase('<c-r>-')/g<cr>']

let b:phpSetGetTemplateFull = 
	\ "public function setPlaceHolder(TypeHolder $placeHolder)\n" .
	\ "{\n" .
	\ "$this->placeHolder = $placeHolder;\n" .
	\ "\n" .
	\ "return $this;\n" .
	\ "}\n" .
	\ "\n" .
	\ "/**\n" .
	\ "@return TypeHolder\n" .
	\ "/\n" .
	\ "public function getPlaceHolder()\n" .
	\ "{\n" .
	\ "return $this->placeHolder;\n" .
	\ "}"

map <leader>sfg "pdiwb"tdiwS<C-R>=b:phpSetGetTemplateFull<cr><esc>
	\v{{{:s/placeHolder/\=SmartCase('<c-r>p')/g<cr>
	\gv:s/typeHolder/\=SmartCase('<c-r>t')/g<cr>']
