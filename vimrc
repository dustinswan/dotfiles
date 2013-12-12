set nocompatible

" Vundle stuff
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-characterize.git'
Bundle 'chrisbra/csv.vim'
Bundle 'szw/vim-dict'
Bundle 'groenewege/vim-less'
Bundle 'digitaltoad/vim-jade'
" Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jQuery'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
" Bundle 'tpope/vim-unimpared'
Bundle 'mileszs/ack.vim'
" Bundle 'Lokaltog/vim-easymotion'
Bundle 'justinmk/vim-sneak'
Bundle 'bkad/CamelCaseMotion'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
" Bundle 'scrooloose/nerdtree'
" Bundle 'altercation/vim-colors-solarized'
Bundle 'w0ng/vim-hybrid'
" Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'gregsexton/MatchTag'
" Bundle 'closetag'
" Bundle 'kana/vim-smartinput'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'mbbill/undotree'
Bundle 'coderifous/textobj-word-column.vim'
" Bundle 'myusuf3/numbers'
" Bundle 'benmills/vimux'
Bundle 'lukaszkorecki/workflowish'
Bundle 'searchfold.vim'
Bundle 'godlygeek/tabular'
Bundle 'kshenoy/vim-signature'
Bundle 'SirVer/ultisnips'
"Bundle 'fmoralesc/vim-pad' " Takes forever to start
Bundle 'lukerandall/haskellmode-vim'
Bundle 'bitc/vim-hdevtools'
" Bundle 'Shougo/neocomplcache'
Bundle 'airblade/vim-gitgutter'
Bundle 'qstrahl/vim-matchmaker'
Bundle 'bling/vim-airline'
Bundle 'matze/vim-move'
Bundle 'bruno-/vim-vertical-move'

let $GIT_SSL_NO_VERIFY = 'true'

filetype plugin indent on " last Vundle requirement

" mouse
if has("mouse")
    set mouse=a
    set ttymouse=xterm
endif

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

" Encryption
set cryptmethod=blowfish

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
"set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
"set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim

" Airline
"let g:airline_left_sep=''
"let g:airline_right_sep=''
" let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" Colors
set background=dark
" colorscheme default
colorscheme hybrid

"let g:solarized_termtrans=1
"let g:solarized_termcolors=256 "default value is 16
"let g:solarized_contrast="high" "default value is normal
"let g:solarized_visibility="high" "default value is normal
"let g:solarized_diffmode="high" "default value is normal
"let g:solarized_hitrail=1 "default value is 0
"colorscheme solarized

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

nnoremap <leader>S :SyntasticToggleMode<cr>

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
nnoremap <leader>W :%s/\s\+$//e<cr>

" Ack
nnoremap <leader>a :Ack<space>
" use ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" Marked
nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>

" Clam
" nnoremap ! :Clam<space>

" Buffer selection
nnoremap <leader>l :ls<cr>:b<space>

" Set the max files
"let g:ctrlp_max_files = 10000
let g:ctrlp_clear_cache_on_exit = 0

" Workflowish stuff. Search for #todo
nnoremap <silent><leader>T :vimgrep /\v^\s*\*+.*#todo.*/i %<cr>:copen<cr>:30wincmd _<cr>
nnoremap <silent><leader>TT /\v^\s*\*+.*#todo.*/i<cr>

" Vimux stuff
nnoremap <silent><leader><leader>vp :VimuxPromptCommand<cr>
nnoremap <silent><leader><leader>vl :VimuxRunLastCommand<cr>
nnoremap <silent><leader><leader>vi :VimuxInspectRunner<cr>
nnoremap <silent><leader><leader>vq :VimuxCloseRunner<cr>
nnoremap <silent><leader><leader>vs :VimuxInterruptRunner<cr>
nnoremap <silent><leader><leader>vx :VimuxClosePanes<cr>
nnoremap <silent><leader><leader>vc :VimuxClearRunnerHistory<cr>

" Vim-Pad
let g:pad_dir = "~/Dropbox/notes/"
let g:pad_search_backend = "ack"

" Haskellmode
let g:ghc = "/usr/bin/ghc"
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest

" Undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Move between splits
map <c-j> <c-w>j<c-w>_
map <c-k> <c-w>k<c-w>_
map <c-l> <c-w>l<c-w>_
map <c-h> <c-w>h<c-w>_

" NeoComplCache
" let g:neocomplcache_enable_at_startup = 1

" hdevtools
nnoremap <leader>ht :HdevtoolsType<cr>
nnoremap <leader>hc :HdevtoolsClear<cr>
nnoremap <leader>hi :HdevtoolsInfo<cr>

" Vim-move
let g:move_key_modifier = 'C'
