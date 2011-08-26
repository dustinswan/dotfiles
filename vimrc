" pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" turn off vi compatability
set nocompatible

" turn off swapfiles
set noswapfile

" persistent undo (>7.3)
set undodir=~/.vim/undodir
set undofile

" indentation
filetype plugin on
filetype indent on
set autoindent
set smartindent

" search
set hlsearch
set incsearch
set showmatch

" tab stops
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

set autoread
set mat=2
set ruler
set nohls

au BufNewFile,BufRead *.less set filetype=less

syntax enable

" solarized colors
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
