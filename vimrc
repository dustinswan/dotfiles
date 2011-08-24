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

" filetype and plugin indentation
filetype plugin on
filetype indent on

" search
set hlsearch
set incsearch
set showmatch

syntax enable

set autoindent
set smartindent

" tabs
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

set autoread
set mat=2
set ruler
set nohls

au BufNewFile,BufRead *.less set filetype=less
