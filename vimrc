" pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" turn off vi compatability, although i hear when vimrc exists this is set
" automatically
set nocompatible

" allow hidden buffers
set hidden

" longer history
set history=1000

" turn off swapfiles
set noswapfile

" persistent undo
if v:version > 703
    set undodir=~/.vim/undodir
    set undofile
endif

" line numbers
set nu

" wild menu
set wildmenu
set wildmode=longest:full

" show the command as it is typed
set sc

" remap the leader to ,. hate doing this but \ is so far away
let mapleader = ","

" when a file is changed externally
set autoread

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

set mat=2
set ruler

" so we get html goodies in php files
au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

syntax enable

" solarized colors
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" NERDTree
nnoremap <silent> <leader>n :NERDTreeToggle <CR>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Tagbar
nnoremap <silent> <leader>t :TagbarToggle <CR>

" hide toolbar in macvim, etc
if has("gui_running")
    set go=-t
endif

" status line. stolen from here:
" https://github.com/lukaszkorecki/DotFiles/blob/master/vimrc
set statusline=
set statusline+=%f\ %2*%m\ %1*%h
set statusline+=%#warningmsg#
if v:version > 700
    set statusline+=%{SyntasticStatuslineFlag()}
endif
set statusline+=%{fugitive#statusline()}
set statusline+=%*
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]
set statusline+=%15.(%c:%l/%L%)\ %P
set laststatus=2

" Syntastic
if v:version > 700
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1
else
    let g:loaded_syntastic_plugin = 1
endif

" Highlight current line
set cursorline

" Highlight column 80
if version > 702
    set colorcolumn=80
endif

" pretty line endings and trailing spaces
set list listchars=tab:»·,trail:·,eol:↪

" fine I'll try it
inoremap jk <Esc>
inoremap kj <Esc>
" stop hitting Esc or c-[!
inoremap <Esc> <nop>
