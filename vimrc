" autocmd VimEnter * echo 'hello'

if 1 - empty(glob("~/.vim/bundle/Vundle.vim"))
	set nocompatible
	filetype off
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	Plugin 'VundleVim/Vundle.vim'
	Plugin 'Valloric/YouCompleteMe' " TODO: replace with deoplete
	Plugin 'scrooloose/nerdtree'
	Plugin 'jistr/vim-nerdtree-tabs'
	Plugin 'pangloss/vim-javascript'
	Plugin 'mxw/vim-jsx'
	let g:jsx_ext_required = 0
	Plugin 'dart-lang/dart-vim-plugin'
	" Plugin 'lambdatoast/elm.vim'
	Plugin 'ElmCast/elm-vim'
	let g:elm_setup_keybindings = 0
	let g:ycm_semantic_triggers = {
		\ 'elm' : ['.'],
		\ }
	Plugin 'tomtom/tcomment_vim'
	Plugin 'ntpeters/vim-better-whitespace'
	Plugin 'mattn/emmet-vim'
	let g:user_emmet_leader_key='<C-f>'
	Plugin 'tpope/vim-fireplace'
	Plugin 'tpope/vim-classpath'
	vnoremap <leader>f :Eval<cr>
	Plugin 'reedes/vim-pencil'

	call vundle#end()
endif

syntax on

au BufNewFile,BufRead *.go set filetype=go
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.purs set filetype=haskell
au BufNewFile,BufRead *.idr set filetype=haskell
"au BufNewFile,BufRead *.elm set filetype=haskell

command! Tabs set noexpandtab tabstop=4 shiftwidth=4
command! Spaces2 set expandtab softtabstop=2 shiftwidth=2
command! Spaces4 set expandtab softtabstop=4 shiftwidth=4
command! Spaces8 set expandtab softtabstop=8 shiftwidth=8
command! Tab8 set tabstop=8 shiftwidth=8

Tabs
au Filetype haskell,cabal,lhaskell Spaces2
au Filetype cpp Spaces4
au Filetype javascript,javascript.jsx Spaces2
au Filetype lisp Spaces2
au Filetype markdown Spaces4
au Filetype elm Spaces4
au Filetype dart Spaces2

command! WriteSudo w !sudo cat > %

" command! DeleteSwapFile echo expand('%:t')

filetype plugin indent on
set smartindent

set number
set relativenumber

set ignorecase
set smartcase
set scrolloff=10

set mouse=nicr

set showcmd

" prevent annoying preview window in autocompletion
set completeopt-=preview

nmap <space> <leader>
vmap <space> <leader>
inoremap jj <esc>
inoremap JJ <esc>
inoremap Jj <esc>
inoremap jJ <esc>
nnoremap ; :
vnoremap ; :
" nnoremap , i_<esc>r
nnoremap <leader>w J
vnoremap <leader>a :w !xclip -sel clip<enter><enter>
" inoremap <C-j> <C-n>
" vnoremap <leader>k :call Comment()<enter>
" vnoremap <leader>l :call Uncomment()<enter>
" nnoremap <leader>k :call Comment()<enter>
" nnoremap <leader>l :call Uncomment()<enter>
nnoremap H gT
nnoremap L gt
nnoremap <C-h> H
nnoremap <C-l> L
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
nnoremap J 8gj
nnoremap K 8gk
vnoremap J 8gj
vnoremap K 8gk
nnoremap gJ 8j
nnoremap gK 8k
vnoremap gJ 8j
vnoremap gK 8k
nnoremap <cr> o<esc>
nnoremap <C-a> <nop>
nnoremap <C-x> <nop>
au filetype elm nnoremap <leader>f :ElmFormat<enter>

nnoremap <c-@> :echo 'hi'<cr>

au filetype tex inoremap <c-j> \
" au filetype tex inoremap <c-h> {
" au filetype tex inoremap <c-l> }
au filetype tex inoremap ; $
au filetype tex nnoremap r; r$
au filetype tex nnoremap <leader>; a;<esc>

" https://gist.github.com/vext01/16df5bd48019d451e078
function! SyncTex()
	execute 'silent !zathura --synctex-forward ' . line('.') . ':' . col('.') . ':' . bufname('%') . ' ' . bufname('%')[:-5] . '.pdf'
	redraw!
endfunction
nnoremap <leader>s :call SyncTex()<cr>

colorscheme desert

" set colorcolumn=80
" highlight ColorColumn ctermbg=darkgrey guibg=darkgrey

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
