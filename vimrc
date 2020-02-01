set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" set nu
set nowrap
sy on
set mouse=a

" set titlestring=[VIM]\ %F\ %r%m titlelen=70 title
set tabstop=4
set shiftwidth=4
set t_Co=256
set encoding=utf-8

" prevent swap file freezes
set noswapfile

" enable vim-airline
set laststatus=2
set ttimeoutlen=50

" enable powerline symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = ''
"let g:airline#extensions#tabline#right_sep = ' '
"let g:airline#extensions#tabline#right_alt_sep = ''

" enable code folding
set foldmethod=indent
set foldlevel=99

" enable copy to system clipboard
set clipboard=unnamedplus

" highlight search results
set hlsearch

set hidden " make buffers hidden by default
nmap <C-PageUp> :bprev<CR>
imap <C-PageUp> <Esc>:bprev<CR>
nmap <C-PageDown> :bnext<CR>
imap <C-PageDown> <Esc>:bnext<CR>
nmap <C-C> :bd<CR>
nnoremap <space> za
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" disable preview on clang_complete
let g:clang_close_preview = 1
set completeopt-=preview
" enable parameter completion
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'

if has("gui_running")
	set guifont=Inconsolata\ 10
	set guioptions-=m
	set guioptions-=T
	set guioptions+=!
	set guioptions-=L
	set guioptions-=r
	colorscheme badwolf
else
	colorscheme badwolf
endif
