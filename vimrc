" set nocompatible " not necessary with neovim

call plug#begin('~/.vim/plugged')

let mapleader="\<Space>"
let maplocalleader="\\"

" Plug 'tomasr/molokai'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-repeat' " repeats plugin maps
Plug 'tpope/vim-surround' " cs[{ -> change surrounding [ to {, cst -> change surrounding tag, ysiw] -> surround inner word with ], etc.
Plug 'tpope/vim-fugitive' " Gdiff, Gblame, Gstatus - to add/reset, Gcommit
Plug 'tpope/vim-endwise' " automatically add end block keyword or symbol
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating' " ctrl-a & ctrl-x on dates works
Plug 'tpope/vim-jdaddy' " cij: change inner json. gqaj: pretty print json
Plug 'w0rp/ale'
Plug 'honza/vim-snippets'
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator' " ctrl-l -> right in vim splits then tmux panes, etc.
Plug 'terryma/vim-multiple-cursors' " ctrl-n -> start & next, ctrl-p -> prev, ctrl-x -> skip
Plug 'easymotion/vim-easymotion' " <leader><leader> w -> word, <leader><leader>fx -> find x
let g:EasyMotion_smartcase = 1
Plug 'justinmk/vim-sneak' " stp -> jump to next occurance of 'tp'. ; -> next. , -> go back, `` -> back home
Plug 'scrooloose/nerdcommenter' " toggle: <leader>c<space>, comment: <leader>cc
Plug 'scrooloose/nerdtree'
nnoremap <leader>t :NERDTreeToggle<cr>
Plug 'mattn/emmet-vim' " ctrl-y,. formely sparkup
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
Plug 'coderifous/textobj-word-column.vim' " cic -> change inner column
Plug 'kshenoy/vim-signature' " mx -> mark x, dmx delete mark x, m, -> place next mark, m. -> place next or toggle, m- -> delete, m<space> -> delete all, ]` jump, etc.
Plug 'junegunn/vim-easy-align' " gaip= -> align inner paragraph on =
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
Plug 'gregsexton/MatchTag' " highlight matching HTML tag
Plug 'qstrahl/vim-matchmaker' " highlight matching word under cursor
let g:matchmaker_enable_startup = 1
let g:matchmaker_ignore_single_match = 1
Plug 'bruno-/vim-vertical-move' " move vertically without changing column: [v, ]v
Plug 'ntpeters/vim-better-whitespace' " highlights trailing whitespace, provides :StripWhiteSpace  
Plug 'sdanielf/vim-stdtabs' " standard indentiation per language
Plug 'mhinz/vim-signify' " vcs in gutter. previously 'airblade/vim-gitgutter'
Plug 'terryma/vim-expand-region' " + to expand, _ to shrink. previously 'gcmt/wildfire.vim'
Plug 'tommcdo/vim-exchange' " e.g. swap words: cxiw, move to other word, cxiw. swap lines: cxx, etc.
Plug 'vim-scripts/argtextobj.vim' " e.g. cia -> change inner argument
Plug 'vim-scripts/matchit.zip' " % will match more things
Plug 'AndrewRadev/splitjoin.vim' " gS, gJ
Plug 'junegunn/goyo.vim' " distraction free mode
nmap <silent> <leader>g :Goyo<cr>
Plug 'jceb/vim-orgmode'
Plug 'sheerun/vim-polyglot' " syntax and indentation for many languages
Plug 'ryanoasis/vim-devicons' " icons in airline, NERDTree, etc.
Plug 'TaDaa/vimade' " fade inactive buffer
Plug 'mhinz/vim-startify' " fancy start page

call plug#end()

" general goodness
syntax enable
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
" set autoindent
" set smartindent

" search
" set hlsearch
" set incsearch
" set gdefault " now substitutions assume /g
set ignorecase
set smartcase " if we include uppercase, it will be case sensitive
" set showmatch " matching brackets
" set matchtime=2 " blink brackets

" clear highlighting
nnoremap <silent><leader>/ :noh<cr>

" regex
set magic

" tab stops
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
" set expandtab
" set smarttab

" mouse
set mouse=a " a = all modes: nvic

" Colors
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
colorscheme nord

" open the current file for edit in Perforce
nnoremap <silent><leader>p4 :! p4 edit %<cr>

" open split and switch to it
nnoremap <leader>v <c-w>v<c-w>l
nnoremap <leader>s <c-w>s<c-w>j

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
" nnoremap <silent> <leader>t :BTags<CR>
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

" Coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-Tab>'
