set nocompatible

" Vundle stuff
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'groenewege/vim-less'
Bundle 'digitaltoad/vim-jade'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'spf13/PIV'
Bundle 'jQuery'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
" Bundle 'mileszs/ack'
Bundle 'Lokaltog/vim-powerline.git'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bkad/CamelCaseMotion'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
" Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
" Bundle 'ervandew/supertab'
" Bundle 'sjl/gundo'
" Bundle 'sjl/clam'
Bundle 'kien/ctrlp.vim'
Bundle 'gregsexton/MatchTag'
" Bundle 'closetag'
Bundle 'kana/vim-smartinput'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'mbbill/undotree'
" Bundle 'Shougo/neocomplcache'
Bundle 'coderifous/textobj-word-column.vim'
" Bundle 'myusuf3/numbers'
" Bundle 'benmills/vimux'
" Bundle 'kikijump/tslime'
Bundle 'lukaszkorecki/workflowish'
Bundle 'searchfold.vim'
Bundle 'godlygeek/tabular'
Bundle 'kshenoy/vim-signature'
Bundle 'SirVer/ultisnips'

filetype plugin indent on " last Vundle requirement

" mouse
set mouse=a
set ttymouse=xterm

" general goodness
set shell=/bin/bash " Syntastic breaks when trying to write to /var/folders
syntax enable
let mapleader=","
let maplocalleader="\\"
set hidden " allow hidden unsaved buffers
set history=1000 " longer history
set noswapfile " turn off swapfiles
set number " line numbers
"set relativenumber " TODO make a command to toggle this. <leader>n maybe..
set showcmd " show the command as it is typed
set showmode
set wildmenu
set backspace=indent,eol,start
set ttyfast
"set wildmode=longest:full
set wildmode=list:longest " try this on for a while
set autoread " when a file is changed externally
set ruler
set cursorline " Highlight current line
set encoding=utf-8 " Necessary to show unicode glyphs
set laststatus=2 " Always show the statusline
set scrolloff=5 " Give us a few lines before and after the cursor

" long lines
set wrap
set formatoptions=rqn1
set textwidth=80
if version > 702
    set colorcolumn=80
endif

" persistent undo
if v:version > 703
    set undodir=~/.vim/undodir
    set undofile
endif

" indentation
set autoindent
set smartindent

" search
set hlsearch
set incsearch
set ignorecase
set gdefault " now substitutions assume /g
set smartcase " if we include uppercase, it will be case sensitive
set showmatch " matching brackets
set matchtime=2 " blink brackets
" turn off highlighting
nnoremap <silent><leader><space> :noh<cr>

" regex " thanks stevelosh
set magic
nnoremap / /\v
vnoremap / /\v

" tab stops
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" pretty line endings and trailing spaces
set list
set listchars=tab:»·,trail:·,eol:¬

" so we get html goodies in php files
au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

set thesaurus+=~/.wordlists/mthesaur.txt
set dictionary+=/usr/share/dict/words

" hide toolbar in macvim, etc
if has("gui_running")
    set gfn=Terminus\ 8
    set go=-t
endif

" Powerline
" let g:Powerline_symbols='fancy'

" Colors
"set background=dark
" colorscheme default

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
"nnoremap <silent> <leader>n :NERDTreeToggle <cr>
"let NERDTreeMinimalUI=1
"let NERDTreeDirArrows=1

" Tagbar
nnoremap <silent><leader>t :TagbarToggle <cr>
" disable tagbar in old Vim
if v:version < 703
    let g:loaded_tagbar=1
endif

" Syntastic
if v:version > 700
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1
else
    let g:loaded_syntastic_plugin=1
endif

nnoremap <leader>s :SyntasticToggleMode<cr>

" Supertab
" let g:SuperTabDefaultCompletionType="context"

" UltiSnpis
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" open the current file for edit in Perforce
nnoremap <silent><leader>4 :! p4 edit %<cr>

" open vsplit and switch to it
nnoremap <leader>v <c-w>v<c-w>l

" trim whitespace
nnoremap <leader>w :%s/\s\+$//e<cr>

" open Ack
" nnoremap <leader>a :Ack<space>

" Marked
nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>

" Clam
" nnoremap ! :Clam<space>

" CtrlP
nnoremap <leader>b :CtrlPBuffer<cr>

" Buffer selection
nnoremap <leader>l :ls<cr>:b<space>

" Set the max files
let g:ctrlp_max_files = 10000

" Workflowish stuff. Search for #todo
nnoremap <silent><leader>T :vimgrep /\v^\s*\*+.*#todo.*/i %<cr>:copen<cr>:30wincmd _<cr>
nnoremap <silent><leader>TT /\v^\s*\*+.*#todo.*/i<cr>
