set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'chrisbra/csv.vim'
"Plugin 'spreadsheet.vim'
Plugin 'szw/vim-dict'
Plugin 'groenewege/vim-less'
Plugin 'digitaltoad/vim-jade'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kchmck/vim-coffee-script'
Plugin 'burnettk/vim-angular'
Plugin 'jQuery'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-characterize.git'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-eunuch'
" Plugin 'tpope/vim-unimpared'
Plugin 'mileszs/ack.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'bkad/CamelCaseMotion'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'w0ng/vim-hybrid'
" Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'gregsexton/MatchTag'
" Plugin 'kana/vim-smartinput'
Plugin 'Raimondi/delimitMate'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'mbbill/undotree'
Plugin 'coderifous/textobj-word-column.vim'
" Plugin 'myusuf3/numbers'
" Plugin 'benmills/vimux'
Plugin 'searchfold.vim'
Plugin 'godlygeek/tabular'
Plugin 'kshenoy/vim-signature'
"Plugin 'SirVer/ultisnips'
"Plugin 'fmoralesc/vim-pad' " Takes forever to start
Plugin 'eagletmt/ghc-mod'
Plugin 'eagletmt/neco-ghc'
"Plugin 'lukerandall/haskellmode-vim'
"Plugin 'bitc/vim-hdevtools'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neocomplcache'
Plugin 'qstrahl/vim-matchmaker'
"Plugin 'bling/vim-airline'
Plugin 'matze/vim-move'
Plugin 'bruno-/vim-vertical-move'
Plugin 'itchyny/calendar.vim'
Plugin 'lfilho/cosco.vim'
Plugin 'ntpeters/vim-better-whitespace'
" No good for IOCOM
Plugin 'sdanielf/vim-stdtabs'
Plugin 'airblade/vim-gitgutter'
Plugin 'gcmt/wildfire.vim'
Plugin 'lambdatoast/elm.vim'

"let $GIT_SSL_NO_VERIFY = 'true'
call vundle#end()
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
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Airline
"let g:airline_left_sep=''
"let g:airline_right_sep=''
" let g:airline_theme='solarized'
"let g:airline_powerline_fonts=1
"let g:airline#extensions#tabline#enabled=1

" Colors
set background=dark
" colorscheme default
colorscheme hybrid

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
    let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
else
    let g:loaded_syntastic_plugin=1
endif

nnoremap <leader>S :SyntasticToggleMode<cr>

" Supertab
" let g:SuperTabDefaultCompletionType="context"

" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" open the current file for edit in Perforce
nnoremap <silent><leader>4 :! p4 edit %<cr>

" open vsplit and switch to it
nnoremap <leader>v <c-w>v<c-w>l

" Ack
nnoremap <leader>a :Ack<space>
" use ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" Clam
" nnoremap ! :Clam<space>

" Buffer selection
nnoremap <leader>l :ls<cr>:b<space>

" Set the max files
"let g:ctrlp_max_files = 10000
let g:ctrlp_clear_cache_on_exit = 0

" Vimux stuff
nnoremap <silent><leader><leader>vp :VimuxPromptCommand<cr>
nnoremap <silent><leader><leader>vl :VimuxRunLastCommand<cr>
nnoremap <silent><leader><leader>vi :VimuxInspectRunner<cr>
nnoremap <silent><leader><leader>vq :VimuxCloseRunner<cr>
nnoremap <silent><leader><leader>vs :VimuxInterruptRunner<cr>
nnoremap <silent><leader><leader>vx :VimuxClosePanes<cr>
nnoremap <silent><leader><leader>vc :VimuxClearRunnerHistory<cr>

" Vim-Pad
"let g:pad_dir = "~/Dropbox/notes/"
"let g:pad_search_backend = "ack"

" Haskellmode
"let g:ghc = "/usr/bin/ghc"
"let g:haddock_browser = "open"
"let g:haddock_browser_callformat = "%s %s"

" hdevtools
"nnoremap <leader>ht :HdevtoolsType<cr>
"nnoremap <leader>hc :HdevtoolsClear<cr>
"nnoremap <leader>hi :HdevtoolsInfo<cr>

let g:necoghc_enable_detailed_browse = 1

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
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" Vim-move
let g:move_key_modifier = 'C'

" Matchmaker on
let g:matchmaker_enable_startup = 1

" Dict word under cursor
nnoremap <leader>d :Dict

" Cosco
autocmd FileType javascript,css nnoremap <silent> ,; :call cosco#commaOrSemiColon()<CR>
autocmd FileType javascript,css inoremap <silent> ,; <ESC>:call cosco#commaOrSemiColon()"<CR>a

" Browser
:let g:netrw_browsex_viewer = "browser"
