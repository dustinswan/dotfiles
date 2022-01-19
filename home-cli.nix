{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
  {
    home.packages = with pkgs; [
    helix ripgrep fd wget mosh w3m nnn urlview gnupg hexyl httpie catimg tealdeer du-dust duplicati bitwarden-cli rage sd eva glow restic tig gitui spotify-tui manix amfora weechat duf procs pandoc magic-wormhole pastel fx
    nodejs deno yarn nodePackages.stylelint nodePackages.js-beautify
    ocaml dune_2 ocamlPackages.utop ocamlPackages.ocp-indent ocamlPackages.merlin
    # racket-minimal
    rustc
    ghc cargo haskell-language-server hlint haskellPackages.hoogle # haskellPackages.cabal
    nixfmt shellcheck fontconfig cmigemo cacert
    emacsPackages.fontawesome emacs-all-the-icons-fonts
    ispell aspell aspellDicts.en aspellDicts.en-computers aspellDicts.en-science aspellDicts.fr aspellDicts.de aspellDicts.eo aspellDicts.es
];

  home.sessionVariables = {
    EDITOR = "hx";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    PATH = "$PATH:${builtins.getEnv "HOME"}/.emacs.d/bin:${builtins.getEnv "HOME"}/.cargo/bin";
    EXA_ICON_SPACING = 2;
  };

  programs.home-manager.enable = true;

  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    newSession = true;
    secureSocket = false;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      continuum
      resurrect # prefix ctrl-s -> save; prefix ctrl-r -> restore
      pain-control # prefix |, -, \, _ to split; prefix h, j, k, l to switch; prefix H, J, K, L to resize; prefix <, > to move
      fzf-tmux-url # prefix u -> fzf urls
      yank # prefix y -> copy command line to clipboard; prefix Y -> copy pwd to clipboard; search + y -> copy to clipboard
      open # highlight: o -> open; ctrl-o -> $EDITOR; S -> web search
      vim-tmux-navigator # ctrl-h, -j, -k, -l -> move between tmux and vim splits
      copycat # prefix ctrl-/ -> regex search; ctrl-f -> file search; ctrl-u -> url search; etc.
    ];
    extraConfig = ''
     set -g set-titles on
     set -g set-titles-string "#H (#S)"
     set -g mouse on
     set -g status-right ""
     set -g status-left ""
     set -g status-style fg=white,bg=black
     set-window-option -g window-status-format '#[fg=black,bright,nodim]#I #[fg=white,bright,dim]#W '
     set-window-option -g window-status-current-format '#[fg=black,bright,nodim]#I #[fg=white,bright,nodim]#W '
    '';
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.zoxide = { # z doc -> cd ~/Documents; zi -> interactive
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "httpie" "aws" "emacs" "fd" "fzf" "mosh" "npm" "ripgrep" "rsync" "sudo" "yarn" ];
    };
    shellAliases = {
      l = "exa -lah --icons --git";
      n = "nnn";
      h = "himalaya";
      er = "rm -rf logs; unzip -o";
      srsync = "rsync --rsync-path='sudo rsync'";
      vim = "echo NO";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = { # ctrl-t, ctrl-r, ssh **<tab>
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type file --color=always";
    defaultOptions = [ "--height 40%" "--border" "--ansi" ];
    fileWidgetCommand = "fd --type file --color=always";
    fileWidgetOptions = [ "--min-height 30 --preview-window noborder --preview '(bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}) 2> /dev/null'" ];
  };

  programs.navi = { # ctrl-G
    enable = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      dustinswan = {
        inherit (secrets.dustinswan) user;
        inherit (secrets.dustinswan) hostname;
      };

      dswan = {
        inherit (secrets.dswan) user;
        inherit (secrets.dswan) hostname;
      };

      aws = {
        inherit (secrets.visionable-aws) user;
        inherit (secrets.visionable-aws) hostname;
        identityFile = "/Users/dustinswan/.ssh/id_rsa";
        extraOptions = { PubkeyAcceptedKeyTypes = "+ssh-rsa"; HostKeyAlgorithms = "+ssh-rsa"; };
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Dustin Swan";
    userEmail = "dustin@dustinswan.com";
    signing = {
      signByDefault = true;
      key = "AD11750151C10881970BD943AB49BD6B2B3A6377";
    };
    aliases = { # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    delta = {
      enable = true;
      options = {
        syntax-theme = "Nord";
      };
    };
  };

  programs.emacs = {
    enable = true;
    package = ((pkgs.emacsPackagesNgGen pkgs.emacs).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };

#  programs.neovim = {
#    enable = true;
#    viAlias = true;
#    vimAlias = true;
#    vimdiffAlias = true;
#    withNodeJs = true;
#    withPython3 = true;
#    coc = {
#      enable = true;
#      settings = ''
#        {
#          "tsserver.formatOnType": true,
#          "coc.preferences.formatOnType": true
#        }
#      '';
#    };
#    plugins = with pkgs.vimPlugins; [ # ale
#      vim-repeat vim-snippets vim-signify vim-orgmode vim-devicons vim-startify vim-highlightedyank
#      emmet-vim # <ctrl-y>,
#      vim-signature # marks in the gutter; mx (add), dmx (delete), m, (place next available), m. (next available if empty), m- (delete all on line), m<space> (delete all)
#      vim-expand-region # + / - to select increasingly larger / smaller regions∑
#      vim-better-whitespace # :StripWhitespace
#      vim-peekaboo # see registers when doing " @ and ctrl-r
#      vim-abolish # Substitution: :Subvert/child{,ren}/adult{,s}/g Coercios: crs (coerce to snake-case), crm (mixed), crc (camel), cru (upper), cr- (dash), cr., cr<space>, crt (title-case)
#      vim-polyglot # includes sensible, dups vim-sleuth
#      argtextobj-vim # daa => delete an argument
#      splitjoin-vim # gS / gJ to turn single-line code into multi, etc.
#      MatchTagAlways # highlights the matching & surrounding tags
#      vim-visual-multi # ctrl-n on word, n/N to select next/prev, [/] to switch cursors, q to skip, Q to remove current
#      # vim-endwise # automatically add end block keyword or symbol
#      vim-fugitive # Git, Gdiff, Gblame, Gstatus, Gcommit
#      vim-speeddating # ctrl-a & ctrl-x on dates
#      jdaddy-vim # cij: change inner json. gqaj: pretty print json
#      vim-surround # cs[{ -> change surrounding [ to {, cst -> change surrounding tag, ysiw] -> surround inner word with ], etc.
#      vim-tmux-navigator # ctrl-l -> right in vim splits then tmux panes, etc.
#      vim-sneak # stp -> jump to next occurance of 'tp'. ; -> next. , -> go back, `` -> back home
#      fzf-vim
#      vim-table-mode # <space>tm, || for rule, <space>tt -> tableize csv
#      tabular # :Tabularize /, :Tabu (shortcut & guess the right thing)
#      vim-markdown # zr, zR, zm, zM, za, zA, zc, zC for folding
#      vim-gnupg
#      vim-floaterm # <leader>T
#      undotree # <leader>u
#      vim-which-key
#      coc-nvim coc-css coc-html coc-eslint coc-tsserver coc-json coc-fzf coc-snippets
#      {
#        plugin = chadtree; # nvim-tree-lua
#        config = "let g:chadtree_settings = { 'xdg': v:true }";
#      }
#      {
#        plugin = vim-easy-align; # gaip= -> align inner paragraph on first =, gaip*= -> align aroud all =
#        config = ''
#          xmap ga <Plug>(EasyAlign)
#          nmap ga <Plug>(EasyAlign)
#        '';
#      }
#      {
#        plugin = vim-easymotion; # <leader><leader> w, <leader><leader>fx -> find x
#        config = "let g:EasyMotion_smartcase = 1";
#      }
#      {
#        plugin = nerdcommenter; # toggle: <leader>c<space>, comment: <leader>cc
#        config = "let g:NERDSpaceDelims = 1";
#      }
#      {
#        plugin = vim-airline;
#        config = ''
#          let g:airline#extensions#tabline#enabled = 1
#          let g:airline#extensions#ale#enabled = 1
#          let g:airline_powerline_fonts = 1
#        '';
#      }
#      vim-airline-themes
#      {
#        plugin = nord-vim;
#        config = ''
#          colorscheme nord
#          let g:nord_italic = 1
#          let g:nord_underline = 1
#        '';
#      }
#    ];
#    extraConfig = ''
#      set hidden
#      set number
#      set ignorecase
#      set smartcase
#      set magic
#      set mouse=a

#      let mapleader="\<Space>"
#      let maplocalleader="\\"

#      let g:org_indent = 1

#      nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
#      nnoremap <silent> <leader>t :CHADopen<CR>
#      nnoremap <silent> <leader>T :FloatermNew<CR>
#      nnoremap <silent> <leader>u :UndotreeToggle<cr>

#      " let g:coc_snippet_next = '<tab>'
#      " let g:coc_snippet_prev = '<S-Tab>'

#      " CoC
#      " Use tab for trigger completion with characters ahead and navigate.
#      inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
#      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

#      " Make <CR> auto-select the first completion item and notify coc.nvim to
#      " format on enter, <cr> could be remapped by other vim plugin
#      inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

#      function! s:check_back_space() abort
#        let col = col('.') - 1
#        return !col || getline('.')[col - 1]  =~# '\s'
#      endfunction

#      " GoTo code navigation.
#      nmap <silent> gd <Plug>(coc-definition)
#      nmap <silent> gy <Plug>(coc-type-definition)
#      nmap <silent> gi <Plug>(coc-implementation)
#      nmap <silent> gr <Plug>(coc-references)

#      " Use K to show documentation in preview window.
#      nnoremap <silent> K :call <SID>show_documentation()<CR>

#      function! s:show_documentation()
#        if (index(['vim','help'], &filetype) >= 0)
#          execute 'h '.expand('<cword>')
#        elseif (coc#rpc#ready())
#          call CocActionAsync('doHover')
#        else
#          execute '!' . &keywordprg . " " . expand('<cword>')
#        endif
#      endfunction

#      " Highlight the symbol and its references when holding the cursor.
#      autocmd CursorHold * silent call CocActionAsync('highlight')

#      nnoremap <silent><leader>/ :noh<cr>
#      nnoremap <leader>v <c-w>v<c-w>l
#      nnoremap <leader>s <c-w>s<c-w>j

#      nnoremap <silent> <leader>a :Rg<CR>
#      nnoremap <silent> <leader>f :Files<CR>
#      nnoremap <silent> <leader>b :Buffers<CR>
#      nnoremap <silent> <leader>w :Windows<CR>
#      nnoremap <silent> <leader>C :Commands<CR>
#      nnoremap <silent> <leader>hf :History<CR>
#      nnoremap <silent> <leader>hc :History:<CR>
#      nnoremap <silent> <leader>hs :History/<CR>
#      nnoremap <silent> <leader>l :BLines<CR>
#      nnoremap <silent> <leader><leader>l :Lines<CR>
#      " nnoremap <silent> <leader>t :BTags<CR>
#      nnoremap <silent> <leader><leader>t :Tags<CR>
#      nnoremap <silent> <leader>gc :BCommits<CR>
#      nnoremap <silent> <leader><leader>gc :Commits<CR>
#      nmap <leader><tab> <plug>(fzf-maps-n)
#      xmap <leader><tab> <plug>(fzf-maps-x)
#      omap <leader><tab> <plug>(fzf-maps-o)
#      imap <c-x><c-k> <plug>(fzf-complete-word)
#      imap <c-x><c-f> <plug>(fzf-complete-path)
#      imap <c-x><c-j> <plug>(fzf-complete-file-ag)
#      imap <c-x><c-l> <plug>(fzf-complete-line)
#    '';
#  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };

  programs.gpg.enable = true;
  programs.mpv.enable = true;
  programs.jq.enable = true;
  programs.noti.enable = true;
  programs.bottom.enable = true;

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    inheritType = "any";
    agents = ["gpg" "ssh"];
    keys = ["id_rsa" "2B3A6377"];
  };

  programs.newsboat = {
    enable = true;
    extraConfig = ''
      urls-source "inoreader"
      inoreader-app-id "${secrets.inoreader.id}"
      inoreader-app-key "${secrets.inoreader.key}"
      inoreader-login "dustin@dustinswan.com"
      inoreader-passwordeval "gpg --decrypt ~/.inoreader-password.gpg"
      inoreader-min-items 100

      unbind-key j
      unbind-key k
      bind-key j down
      bind-key k up
    '';
  };

  home.file.gitui = {
    target = ".config/gitui/key_bindings.ron";
    text = ''(
    focus_right: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
    focus_left: Some(( code: Char('h'), modifiers: ( bits: 0,),)),
    focus_above: Some(( code: Char('k'), modifiers: ( bits: 0,),)),
    focus_below: Some(( code: Char('j'), modifiers: ( bits: 0,),)),

    open_help: Some(( code: F(1), modifiers: ( bits: 0,),)),

    move_left: Some(( code: Char('h'), modifiers: ( bits: 0,),)),
    move_right: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
    move_up: Some(( code: Char('k'), modifiers: ( bits: 0,),)),
    move_down: Some(( code: Char('j'), modifiers: ( bits: 0,),)),
    popup_up: Some(( code: Char('p'), modifiers: ( bits: 2,),)),
    popup_down: Some(( code: Char('n'), modifiers: ( bits: 2,),)),
    page_up: Some(( code: Char('b'), modifiers: ( bits: 2,),)),
    page_down: Some(( code: Char('f'), modifiers: ( bits: 2,),)),
    home: Some(( code: Char('g'), modifiers: ( bits: 0,),)),
    end: Some(( code: Char('G'), modifiers: ( bits: 1,),)),
    shift_up: Some(( code: Char('K'), modifiers: ( bits: 1,),)),
    shift_down: Some(( code: Char('J'), modifiers: ( bits: 1,),)),

    edit_file: Some(( code: Char('I'), modifiers: ( bits: 1,),)),

    status_reset_item: Some(( code: Char('U'), modifiers: ( bits: 1,),)),

    diff_reset_lines: Some(( code: Char('u'), modifiers: ( bits: 0,),)),
    diff_stage_lines: Some(( code: Char('s'), modifiers: ( bits: 0,),)),

    stashing_save: Some(( code: Char('w'), modifiers: ( bits: 0,),)),
    stashing_toggle_index: Some(( code: Char('m'), modifiers: ( bits: 0,),)),

    stash_open: Some(( code: Char('l'), modifiers: ( bits: 0,),)),

    abort_merge: Some(( code: Char('M'), modifiers: ( bits: 1,),)),
)'';
  };

  home.file.helix = {
    target = ".config/helix/config.toml";
    text = "theme = \"nord\"";
  };
}
