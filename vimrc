set nocompatible

call plug#begin('~/.vim/plugged')

"Plug 'gmarik/Vundle.vim'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'szw/vim-dict'
Plug 'burnettk/vim-angular'
Plug 'jQuery'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-unimpared'
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
Plug 'bkad/CamelCaseMotion'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'w0ng/vim-hybrid'
" Plug 'ervandew/supertab'
Plug 'kien/ctrlp.vim'
Plug 'gregsexton/MatchTag'
" Plug 'kana/vim-smartinput'
Plug 'Raimondi/delimitMate'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'mbbill/undotree'
Plug 'coderifous/textobj-word-column.vim'
Plug 'benmills/vimux'
Plug 'searchfold.vim'
Plug 'godlygeek/tabular'
Plug 'tommcdo/vim-lion'
Plug 'kshenoy/vim-signature'
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'eagletmt/ghc-mod'
"Plug 'eagletmt/neco-ghc'
"Plug 'lukerandall/haskellmode-vim'
Plug 'bitc/vim-hdevtools'
Plug 'idris-hackers/idris-vim'
Plug 'qstrahl/vim-matchmaker'
Plug 'bling/vim-airline'
Plug 'matze/vim-move'
Plug 'bruno-/vim-vertical-move'
Plug 'itchyny/calendar.vim'
Plug 'lfilho/cosco.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sdanielf/vim-stdtabs'
Plug 'airblade/vim-gitgutter'
Plug 'gcmt/wildfire.vim'
Plug 'lambdatoast/elm.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/goyo.vim'
Plug 'EinfachToll/DidYouMean'

call plug#end()

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

" Colors
" colorscheme default
colorscheme hybrid
set background=dark

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
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" open the current file for edit in Perforce
nnoremap <silent><leader>4 :! p4 edit %<cr>

" open vsplit and switch to it
nnoremap <leader>v <c-w>v<c-w>l

" Buffer selection
nnoremap <leader>l :ls<cr>:b<space>

" Set the max files
"let g:ctrlp_max_files = 10000
let g:ctrlp_clear_cache_on_exit = 0

" Vimux
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vq :VimuxCloseRunner<CR>
nnoremap <Leader>vx :VimuxInterruptRunner<CR>
nnoremap <Leader>vz :call VimuxZoomRunner()<CR>

" Haskellmode
"let g:ghc = "/usr/bin/ghc"
"let g:haddock_browser = "open"
"let g:haddock_browser_callformat = "%s %s"

" hdevtools
nnoremap <leader>ht :HdevtoolsType<cr>
nnoremap <leader>hc :HdevtoolsClear<cr>
nnoremap <leader>hi :HdevtoolsInfo<cr>

autocmd BufEnter *.hs set formatprg=pointfree

"let g:necoghc_enable_detailed_browse = 1

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest

" Undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Move between splits
map <c-l> <c-w>l<c-w>_
map <c-h> <c-w>h<c-w>_

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

" Calendar
let g:calendar_google_calendar = 1

" Ack
"nnoremap <leader>a :Ack<space>
" No wait, Ack motion! Thanks again sjl
nnoremap <silent> <leader>a :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> <leader>a :<C-U>call <SID>AckMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
    if a:type ==# 'v'
    silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
    silent execute "normal! `[v`]y"
    endif
endfunction

function! s:AckMotion(type) abort
    let reg_save = @@

    call s:CopyMotionForType(a:type)

    execute "normal! :Ack! --literal " . shellescape(@@) . "\<cr>"

    let @@ = reg_save
endfunction

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
