{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{

  home.packages = with pkgs; [
    ripgrep fd wget silver-searcher tree ranger nodejs yarn mosh w3m urlview nmap tuir gnupg youtube-dl nodePackages.tern nodePackages.eslint nodePackages.javascript-typescript-langserver ffmpeg ispell aspell aspellDicts.en aspellDicts.en-computers aspellDicts.en-science aspellDicts.fr aspellDicts.de aspellDicts.eo aspellDicts.es hexyl nnn entr httpie cacert catimg tldr ffsend du-dust duplicati python3 bitwarden-cli rage
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    PATH = "$PATH:${builtins.getEnv "HOME"}/.emacs.d/bin:${builtins.getEnv "HOME"}/.radicle/bin:${builtins.getEnv "HOME"}/.cargo/bin";

    P4USER = "dswan";
    P4PORT = "humu.iocom.com:1666";
    P4CONFIG = "p4.cfg";
    P4EDITOR = "vim";
    P4IGNORE = ".ignore";
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
     set -g status-bg default
     set -g window-status-format '#[fg=black,bright,nodim]#I #[fg=white,bright,dim]#W '
     set -g window-status-current-format '#[fg=black,bright,nodim]#I #[fg=white,bright,nodim]#W '
    '';
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
    shellAliases = {
      # l = "ls -la";
      n = "nnn";
      t = "tmux attach -d";
      er = "rm -rf logs; unzip -o";
      srsync = "rsync --rsync-path='sudo rsync'";
    };
  };

  # programs.dircolors = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type file --color=always";
    defaultOptions = [ "--height 40%" "--border" "--ansi" ];
    fileWidgetCommand = "fd --type file --color=always";
    fileWidgetOptions = [ "--min-height 30 --preview-window noborder --preview '(bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}) 2> /dev/null'" ];
  };

  programs.broot = {
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
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Dustin Swan";
    userEmail = "dustin@dustinswan.com";
    signing = {
      # signByDefault = true;
      key = "AD11750151C10881970BD943AB49BD6B2B3A6377";
    };
    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };

  programs.emacs = {
    enable = true;
    package = ((pkgs.emacsPackagesNgGen pkgs.emacs).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    # unimpaired endwise textobj-word-column MatchTag vim-matchmaker vim-vertical-move stdtabs matchit splitjoin vimade fuzzymenu vim-markdown
    plugins = with pkgs.vimPlugins; [ nord-vim vim-airline vim-airline-themes vim-sensible vim-repeat vim-surround vim-fugitive vim-speeddating jdaddy-vim ale vim-snippets fzf-vim vim-tmux-navigator vim-multiple-cursors vim-easymotion vim-sneak nerdcommenter emmet-vim undotree vim-signature vim-easy-align vim-better-whitespace vim-signify vim-expand-region vim-exchange argtextobj-vim goyo vim-orgmode vim-polyglot vim-devicons vim-startify vim-abolish vim-peekaboo vim-table-mode tabular coc-nvim coc-css coc-html coc-eslint coc-tsserver coc-json coc-fzf coc-snippets vim-highlightedyank vim-which-key vim-floaterm ];
    extraConfig = ''
      set expandtab
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2

      set hidden
      set number
      set ignorecase
      set smartcase
      set magic
      set mouse=a

      let mapleader="\<Space>"
      let maplocalleader="\\"
      nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

      let g:EasyMotion_smartcase = 1

      let g:NERDSpaceDelims = 1

      let g:coc_snippet_next = '<tab>'
      let g:coc_snippet_prev = '<S-Tab>'

      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#ale#enabled = 1
      let g:airline_powerline_fonts = 1

      " let g:ale_fixers = {'php': ['php-cs-fixer']}

      let g:nord_italic = 1
      " let g:nord_italic_comments = 1
      let g:nord_underline = 1
      colorscheme nord
      highlight Folded cterm=italic,bold ctermbg=0 ctermfg=12 guibg=#3B4252 guifg=#81A1C1

      let g:org_indent = 1

      nnoremap <silent><leader>p4 :! p4 edit %<cr>
      nnoremap <silent><leader>/ :noh<cr>
      nnoremap <leader>v <c-w>v<c-w>l
      nnoremap <leader>s <c-w>s<c-w>j
      nnoremap <leader>u :UndotreeToggle<cr>
      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)

      nnoremap <silent> <leader>a :Ag<CR>
      nnoremap <silent> <leader>f :Files<CR>
      nnoremap <silent> <leader>b :Buffers<CR>
      nnoremap <silent> <leader>w :Windows<CR>
      nnoremap <silent> <leader>C :Commands<CR>
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

      nnoremap <silent> <leader>n :FloatermNew nnn<CR>
      nnoremap <silent> <leader>T :FloatermNew<CR>
    '';
  };

  programs.bat.enable = true;
  programs.gpg.enable = true;
  programs.htop.enable = true;
  programs.mpv.enable = true;
  programs.jq.enable = true;

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    inheritType = "any";
    agents = ["gpg" "ssh"];
    keys = ["id_rsa" "2B3A6377"];
  };

  # programs.newsboat = {
  #   enable = true;
  #   extraConfig = ''
  #     urls-source "ttrss"
  #     ttrss-url "https://tt-rss.dustinswan.com/"
  #     ttrss-login "dustinswan"
  #     ttrss-passwordeval "gpg -dq ~/.dustinswan@tt-rss.dustinswan.com.gpg"
  #   '';
  # };
}
