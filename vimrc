" autocmd VimEnter * echo 'hello'

if 1 - empty(glob("~/.vim/bundle/Vundle.vim"))
	set nocompatible
	filetype off
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'scrooloose/nerdtree'
	Plugin 'jistr/vim-nerdtree-tabs'
	Plugin 'pangloss/vim-javascript'
	Plugin 'mxw/vim-jsx'
	let g:jsx_ext_required = 0
	Plugin 'dart-lang/dart-vim-plugin'
	"Plugin 'lambdatoast/elm.vim'
	Plugin 'ElmCast/elm-vim'
	Plugin 'tpope/vim-commentary'
	call vundle#end()
endif

syntax on

au BufNewFile,BufRead *.go set filetype=go
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.purs set filetype=haskell
"au BufNewFile,BufRead *.elm set filetype=haskell

set noexpandtab
set tabstop=4
set shiftwidth=4
au Filetype haskell,cabal,lhaskell set expandtab shiftwidth=2 softtabstop=2
au Filetype javascript,cpp set expandtab softtabstop=4
au Filetype lisp set expandtab shiftwidth=2
au Filetype markdown set expandtab shiftwidth=4 softtabstop=4

command! Tabs set noexpandtab tabstop=4 shiftwidth=4
command! Spaces2 set expandtab softtabstop=2 shiftwidth=2
command! Spaces4 set expandtab softtabstop=4 shiftwidth=4

filetype plugin indent on
set smartindent

set number
set relativenumber

nmap <space> <leader>
vmap <space> <leader>
inoremap jj <esc>
inoremap JJ <esc>
inoremap Jj <esc>
inoremap jJ <esc>
nnoremap ; :
vnoremap ; :
nnoremap , i_<esc>r
nnoremap <leader>w J
nnoremap J 8j
nnoremap K 8k
vnoremap <leader>a :w !xclip -sel clip<enter><enter>
" inoremap <C-j> <C-n>
" vnoremap <leader>k :call Comment()<enter>
" vnoremap <leader>l :call Uncomment()<enter>
" nnoremap <leader>k :call Comment()<enter>
" nnoremap <leader>l :call Uncomment()<enter>
inoremap <C-h> <esc>gT
nnoremap <C-h> gT
inoremap <C-l> <esc>gt
nnoremap <C-l> gt
nnoremap j gj
nnoremap k gk
nnoremap <cr> o<esc>

colorscheme desert

au BufNewFile,BufRead * setlocal formatoptions-=cro

au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\ 	exe "normal! g'\"" |
			\ endif

"let b:comment=""
"function Comment()
"	exec ":normal 0i".b:comment
"endfunction
"function Uncomment()
"	exec ":normal ^".strlen(b:comment)."x"
"endfunction
"au Filetype haskell,lhaskell,cabal,elm let b:comment="--"
"au Filetype javascript,html,java,c,cpp,go,dart let b:comment="//"
"au Filetype cfg,conf,python,ruby,sh let b:comment="#"
"au Filetype clojure,lisp let b:comment=";"
"au Filetype vim let b:comment="\""

"set nowrap
"disable line wrapping
