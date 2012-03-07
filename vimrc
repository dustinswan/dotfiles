set nocompatible

" Vundle stuff
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Custom Bundles:
Bundle 'groenewege/vim-less'
Bundle 'digitaltoad/vim-jade'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jQuery'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bkad/CamelCaseMotion'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
" Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
" Bundle 'ervandew/supertab'
" Bundle 'sjl/gundo.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'gregsexton/MatchTag'
Bundle 'closetag.vim'

" Snipmate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'snipmate-snippets'
Bundle 'garbas/vim-snipmate'

filetype plugin indent on " last Vundle requirement

syntax enable
set hidden " allow hidden buffers
set history=1000 " longer history
set noswapfile " turn off swapfiles
set nu " line numbers
set sc " show the command as it is typed
set wildmenu
set wildmode=longest:full
let mapleader = ","
set autoread " when a file is changed externally
set mat=2
set ruler
set cursorline " Highlight current line
set encoding=utf-8 " Necessary to show unicode glyphs
set laststatus=2 " Always show the statusline

" Powerline
let g:Powerline_symbols='fancy'

" persistent undo
if v:version > 703
    set undodir=~/.vim/undodir
    set undofile
endif

" indentation
filetype plugin on
filetype indent on
set autoindent
set smartindent

" search
set hlsearch
set incsearch
set smartcase
set showmatch " matching brackets
set matchtime=2 " blink brackets

" tab stops
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" so we get html goodies in php files
au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

" Solarized
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256 "default value is 16
let g:solarized_contrast="high" "default value is normal
let g:solarized_visibility="high" "default value is normal
let g:solarized_diffmode="high" "default value is normal
let g:solarized_hitrail=1 "default value is 0
colorscheme solarized

" NERDTree
"nnoremap <silent> <leader>n :NERDTreeToggle <CR>
"let NERDTreeMinimalUI=1
"let NERDTreeDirArrows=1

" Tagbar
nnoremap <silent> <leader>t :TagbarToggle <CR>

" hide toolbar in macvim, etc
if has("gui_running")
    set go=-t
endif

" Syntastic
if v:version > 700
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1
else
    let g:loaded_syntastic_plugin=1
endif

" Supertab
" let g:SuperTabDefaultCompletionType="context"

" Highlight column 80
if version > 702
    set colorcolumn=80
endif

" pretty line endings and trailing spaces
set list listchars=tab:»·,trail:·,eol:↪

" turn off highlighting
" nnoremap <Esc> :noh<CR><Esc>

" open the current file for edit in Perforce
nnoremap <leader>p :! p4 edit %<CR>

" disable tagbar in old Vim
if v:version < 703
    let g:loaded_tagbar=1
endif
