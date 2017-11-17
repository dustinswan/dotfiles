set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-characterize'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-jdaddy'
Plug 'w0rp/ale' " previously 'neomake/neomake, 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " previously YouCompleteMe
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'gregsexton/MatchTag' " highlight matching HTML tag
Plug 'Raimondi/delimitMate'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'mbbill/undotree'
Plug 'coderifous/textobj-word-column.vim'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vim-easy-align'
Plug 'qstrahl/vim-matchmaker' " highlight matching word under cursor
Plug 'bruno-/vim-vertical-move'
Plug 'lfilho/cosco.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sbdchd/neoformat'
Plug 'sdanielf/vim-stdtabs'
Plug 'mhinz/vim-signify' " previously 'airblade/vim-gitgutter'
Plug 'terryma/vim-expand-region' " previously 'gcmt/wildfire.vim'
Plug 'tommcdo/vim-exchange'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/matchit.zip' " % will match more things
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/utl.vim'
Plug 'junegunn/goyo.vim'
Plug 'EinfachToll/DidYouMean'
Plug 'jceb/vim-orgmode'

" Languages & Syntax
Plug 'sheerun/vim-polyglot'
Plug 'dleonard0/pony-vim-syntax'
Plug 'idris-hackers/idris-vim'
Plug 'eagletmt/ghc-mod'
Plug 'bitc/vim-hdevtools'
"Plug 'eagletmt/neco-ghc'
"Plug 'lukerandall/haskellmode-vim'
Plug 'ryanoasis/vim-devicons'

" Themes
"Plug 'w0ng/vim-hybrid'
"Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'

call plug#end()

" general goodness
"set shell=/bin/bash " Syntastic breaks when trying to write to /var/folders
syntax enable
let mapleader="\<Space>"
" let mapleader=","
let maplocalleader="\\"
set hidden " allow hidden unsaved buffers
set history=1000 " longer history
set noswapfile " turn off swapfiles
set number " line numbers
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
" set colorcolumn=80

" persistent undo
set undodir=~/.vim/undodir
set undofile

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

" clear highlighting
nnoremap <silent><leader>/ :noh<cr>

" regex
set magic

" tab stops
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" mouse
set mouse=nicr

" so we get html goodies in php files
"au BufRead *.php set ft=php.html
"au BufNewFile *.php set ft=php.html

" set thesaurus+=~/.wordlists/mthesaur.txt
set dictionary+=/usr/share/dict/words

" hide toolbar, etc.
if has("gui_running")
    set gfn=Terminus\ 8
    set go=-t
endif

" Colors
" colorscheme monokai
colorscheme molokai
highlight Normal ctermbg=NONE
highlight SignColumn ctermbg=NONE
highlight LineNr ctermbg=NONE ctermfg=darkgrey
" highlight StatusLine guibg=NONE ctermfg=NONE ctermbg=red

" Tagbar
nnoremap <silent><leader>t :TagbarToggle <cr>

" Supertab
" let g:SuperTabDefaultCompletionType="context"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" open the current file for edit in Perforce
nnoremap <silent><leader>p4 :! p4 edit %<cr>

" open split and switch to it
nnoremap <leader>v <c-w>v<c-w>l
nnoremap <leader>s <c-w>s<c-w>j

" Haskellmode
"let g:ghc = "/usr/bin/ghc"
"let g:haddock_browser = "open"
"let g:haddock_browser_callformat = "%s %s"

" hdevtools
" nnoremap <leader>ht :HdevtoolsType<cr>
" nnoremap <leader>hc :HdevtoolsClear<cr>
" nnoremap <leader>hi :HdevtoolsInfo<cr>
" autocmd BufEnter *.hs set formatprg=pointfree

" automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menu,preview,longest

" Undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Matchmaker
let g:matchmaker_enable_startup = 1

" Cosco
autocmd FileType javascript,css nmap <silent> <leader>; <Plug>(cosco-commaOrSemiColon)
autocmd FileType javascript,css imap <silent> <leader>; <c-o><Plug>(cosco-commaOrSemiColon)

" Browser
let g:netrw_browsex_viewer = "browser"

" FZF
nnoremap <silent> <leader>a :Ag<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>w :Windows<CR>
nnoremap <silent> <leader>c :Commands<CR>
nnoremap <silent> <leader>hf :History<CR>
nnoremap <silent> <leader>hc :History:<CR>
nnoremap <silent> <leader>hs :History/<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader><leader>l :Lines<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader><leader>t :Tags<CR>
nnoremap <silent> <leader>gc :BCommits<CR>
nnoremap <silent> <leader><leader>gc :Commits<CR>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" EasyMotion
let g:EasyMotion_smartcase = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" vim-tmux-navigator - needed due to a bug in MacOS terminfo
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" Tabs
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt

" Goyo
nmap <silent> <leader>g :Goyo<cr>

" Airline
let g:airline#extensions#tabline#enabled = 1
