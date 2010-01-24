"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dedmajor's config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" XXX NOTE: Using vi/vim properly, you don't use it modally. You are always in
" normal mode, and only enter insert mode for short bursts of typing text,
" after which you press to go to normal mode.
" © http://www.viemu.com/a–why–vi–vim.html

" My favourite packages:
" eclim
" app-vim/closetag
" app-vim/gentoo-syntax
" app-vim/latexsuite
" bufexplorer
" app-vim/pushpop
" app-vim/colorschemes
" app-vim/vim-spell-en
" app-vim/vim-spell-ru
" media-fonts/dina

" TODO: <++> placeholders like in latexsuite for brackets
" printer encoding for cyrillic text
" ddbg - var from register C-R a
" xim
" very minor:
" includeexpr - for matching include dirname(__FILE__) and file current dir
"
language C

syntax on
colorscheme phphaxor

"Fast reloading of the .vimrc
map <leader>vs :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>ve :e! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

set ch=1
set laststatus=2

set autoread

set history=2000

set encoding=UTF-8

" use CTRL-^ to switch into russian typing mode
" TODO: xim
"set keymap=russian-jcukenwin

set wildmenu
set wim=longest:full
set wcm=<Tab> 

set hlsearch

set ai
set si

set wrap

" Most common commands:
noremap <F2> :bp<CR>
inoremap <F2> <C-O>:bp<CR>
cnoremap <F2> <C-C>:bp<CR>

noremap <F3> :bn<CR>
inoremap <F3> <C-O>:bn<CR>
cnoremap <F3> <C-C>:bn<CR>

noremap <F11> :q<CR>
inoremap <F11> <C-O>:q<CR>
cnoremap <F11> <C-C>:q<CR>

noremap <F12> :Bclose<CR>
inoremap <F12> <C-O>:Bclose<CR>
cnoremap <F12> <C-C>:Bclose<CR>

set pastetoggle=<F5>

noremap <F4> :nohl<CR>
inoremap <F4> <C-O>:nohl<CR>
cnoremap <F4> <C-C>:nohl<CR>

" go into directory of the current file
map <leader>ccd :cd %:p:h<cr>


map <F9> :make<cr>
imap <F9> <C-O>:make<cr>

" latexsuite need -H
set grepprg=grep\ -nH\ $*


map <C-F8> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg

map <leader>gb viWy:new<cr>:r !svn blame <c-r>"<cr>gg
map <leader>gl :r !svn log -c <c-r><c-w><cr>
map <leader>gd :new +set\ modifiable\|set\ ft=diff\|r\ !~/bin/crucDiff.sh\ <c-r><c-w><cr>gg

" edit your ~/.gnopasterrc
au BufNewFile,BufRead * let b:gnopaste_lang=""
au FileType php let b:gnopaste_lang="PHP"
vmap <leader>gp :w !gnopaster -l <c-r>=b:gnopaste_lang<cr><cr>

" gf - edit new file, if not exists
map gf :e <cfile><CR>

vmap < <gv
vmap > >gv


" eclim bindings
if has("gui") && exists(":PingEclim")
	" eclim smart autocomplete
	imap <S-TAB> <C-X><C-U>
else
	" else complete by tags
	imap <S-TAB> <C-X><C-]>
endif

if exists(":PingEclim")
	map <leader>pcd :ProjectCD<cr>

	" as suggested by man:
	au FileType php nnoremap <silent> <buffer> <cr> :PhpSearchContext<cr>

	" really annoying:
	let g:EclimShowCurrentError=0

	map <C-S-F9> :Validate<cr>
	imap <C-S-F9> <C-O>:Validate<cr>

	" buggy command, which switch buffers after make
	au BufRead * au! eclim_ant_make
endif


" todo: remove?
" temp bugfix after upgrage to 7.2.021
" see  /usr/share/vim/vim72/ftplugin/php.vim
"     20 runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim
" see also: let g:PHP_autoformatcomment = 0
" au FileType php set comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-

" au FileType php,html setl dictionary+=~/.vim/dictionairies/funclist.txt
au FileType php,html setl keywordprg=~/bin/php_doc
" dictionary is very annoying, todo: lesser dictionary
" au FileType php,html setl complete+=k


" programmer's spellchecking by dedmajor (c)
map <leader>rt :%s/\(\([a-zA-Z][a-z]\+\)\\|\([A-Z]\+[a-z]\@!\)\)<C-Q>000\@!/\1<C-Q>000/Ig<CR>:nohl<CR>:set spell<CR>``
map <leader>tr :%s/<C-Q>000//g<CR>:nohl<CR>:set nospell<CR>``


" no unary tags, we are using xhtml and xml
au BufNewFile,BufRead html,xml,php let b:unaryTagsStack=""


command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete ".l:currentBufNum)
	endif
endfunction


"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=php<cr>
map <leader>2 :set syntax=javascript<cr>
map <leader>3 :set syntax=html<cr>
map <leader>4 :set ft=txt<cr>
map <leader>5 :set ft=xml<cr>
map <leader>$ :syntax sync fromstart<cr>

" tabs like in zde
map <leader>l :set invlist listchars=tab:»\ ,trail:·<cr>
hi SpecialKey guifg=#555555 ctermfg=7


set so=7

set ruler

set cmdheight=2

set nu

set lz

set hid

set backspace=eol,start,indent

set whichwrap+=<,>,h,l

set ignorecase
set incsearch

set magic

set noerrorbells
set novisualbell
set t_vb=

set showmatch

set mat=2

set hlsearch


set laststatus=2

set statusline=%3n\ %F%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}\ \ \ \ %l/%L:%c%V


" map is just a view for windows
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove


func! DeleteTrailingWS()
	exe "normal mz"
	%s/\([^\t\s]\)\s\+$/\1/ge
	exe "normal `z"
endfunc
"autocmd BufWrite *.php :call DeleteTrailingWS()


"set binary
"au BufWritePre * :set bin | set noeol
"au BufWritePost * :set nobin | set eol

set completeopt=menuone,preview


" fast saving (Zend)
noremap <C-S>   :update<CR>
vnoremap <C-S>    <C-C>:update<CR>
inoremap <C-S>    <C-O>:update<CR>

" fast undo (Zend)
inoremap <c-z> <c-o>u


" smart <CR> by dedmajor. newlines should be with leading tabs (onphp style)
" (considered as useless and harmful thing by vim users)
"func! NewLine()
"	let line = getline('.')
"	
"	if line =~ '^\t*$'
"		return "\<End>\<CR>"
"	else
"		return "\<CR>"
"	endif
"endfunc


" patched by dedmajor
function! Browser ()
	let line0 = getline (".")

	let line = matchstr (line0, "http[^ >]*")

	if line==""
		let line = matchstr (line0, "ftp[^ >]*")
	endif

	if line==""
		let line = matchstr (line0, "file[^ >]*")
	endif

	"let line = escape (line, "#?&;|%")
	let line = escape (line, "#%")
	
	exec ':silent !firefox '.'"'.line.'" >/dev/null 2>&1 &'
	exec ':redr!'
	
endfunction

map <leader>gu :call Browser ()<CR>



" by dedmajor: removing ZEBRA
"map <leader>i /^$/<CR>qi

iab xdt <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
iab xdate <c-r>=strftime("%Y-%m-%d")<cr>


set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


set nobackup
"set nowb
"set noswapfile


set nofen
set fdl=0
set foldmethod=marker
set foldcolumn=4


" 79 is a default width for autoformatting
set tw=79

" only format comments
set fo=croq


let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1

"To HTML
let html_use_css = 1
let html_number_lines = 0
let use_xhtml = 1

"au FileType html,cheetah set ft=xml
au FileType html,cheetah set syntax=html

let g:Tex_DefaultTargetFormat="pdf"


"Remove the Window$ ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
