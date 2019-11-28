{ pkgs, ... }:

{
  # nodePackages.eslint
  home.packages = with pkgs; [
    ripgrep fd wget silver-searcher tree ranger nodejs yarn mosh w3m urlview nmap rtv gnupg youtube-dl nodePackages.tern nodePackages.javascript-typescript-langserver nodePackages.js-beautify nodePackages.prettier ffmpeg ispell aspell aspellDicts.en aspellDicts.en-computers aspellDicts.en-science aspellDicts.fr aspellDicts.de aspellDicts.eo aspellDicts.es hexyl nnn entr httpie cacert
  ];

  home.sessionVariables = {
    EDITOR = "vim";

    P4USER = "dswan";
    P4PORT = "humu.iocom.com:1666";
    P4CONFIG = "p4.cfg";
    P4EDITOR = "nvim";
    P4IGNORE = ".ignore";
  };

  programs.home-manager.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 12;
          y = 12;
        };
        dimentions = {
          columns = 0;
          lines = 0;
        };
      };
      font = {
        normal.family = "Iosevka Nerd Font";
        bold.family = "Iosevka Nerd Font";
        italic.family = "Iosevka Nerd Font";
        size = 18.0;
      };
      key_bindings = [
        {
          key = "N";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];
      background_opacity = 0.95;
      colors = {
        primary = {
          background = "0x2E3440";
          foreground = "0xD8DEE9";
        };
        cursor = {
          text = "0x2E3440";
          cursor = "0xD8DEE9";
        };
        normal = {
          black = "0x3B4252";
          red = "0xBF616A";
          green = "0xA3BE8C";
          yellow = "0xEBCB8B";
          blue = "0x81A1C1";
          magenta = "0xB48EAD";
          cyan = "0x88C0D0";
          white = "0xE5E9F0";
        };
        bright = {
          black = "0x4C566A";
          red = "0xBF616A";
          green = "0xA3BE8C";
          yellow = "0xEBCB8B";
          blue = "0x81A1C1";
          magenta = "0xB48EAD";
          cyan = "0x8FBCBB";
          white = "0xECEFF4";
        };
      };
    };
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    secureSocket = false;
    plugins = with pkgs.tmuxPlugins; [ sensible resurrect pain-control continuum copycat open urlview fzf-tmux-url yank vim-tmux-navigator ];
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

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "refined";
    };
    shellAliases = {
      l = "ls -la";
      n = "nnn -isl";
      ta = "tmux attach -d";
      e = "emacsclient -a \"\" -t -nw";
      weather = "curl http://wttr.in";
      er = "rm -rf logs; unzip -o";
      srsync = "rsync --rsync-path='sudo rsync'";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      dustinswan = {
        hostname = "dustinswan.com";
        user = "dustinswan";
      };

      dswan = {
        hostname = "dswan.iocom.com";
        user = "ec2-user";
      };

      kmcglynn = {
        hostname = "kmcglynn.iocom.com";
        user = "centos";
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
    aliases = {
      s = "status";
      a = "add";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };

  accounts.email = {
    maildirBasePath = "Mail";
    certificatesFile = "${builtins.getEnv "HOME"}/.nix-profile/etc/ssl/certs/ca-bundle.crt";

    accounts = {
      FastMail = {
        address = "dustin@dustinswan.com";
        aliases = "dustinswan@gmail.com";
        realName = "Dustin Swan";
        primary = true;
        folders = {
          inbox = "INBOX";
          drafts = "INBOX.Drafts";
          sent = "INBOX.Sent";
          trash = "INBOX.Trash";
        };
        userName = "dustinswan@fastmail.com";
        imap.host = "mail.messagingengine.com";
        smtp.host = "mail.messagingengine.com";
        passwordCommand = "gpg -dq ${builtins.getEnv "HOME"}/.dustinswan@fastmail.com-password.gpg";
        offlineimap.enable = true;
        msmtp.enable = true;
        signature = {
          text = ''
            Dustin Swan
            dustinswan.com
          '';
          showSignature = "append";
        };
      };

      Visionable = {
        address = "dswan@visionable.com";
        aliases= "dswan@iocom.com";
        realName = "Dustin Swan";
        folders = {
          inbox = "INBOX";
          drafts = "Drafts";
          sent = "Sent Items";
          trash = "Deleted Items";
        };
        userName = "dswan@visionable.com";
        imap.host = "outlook.office365.com";
        smtp.host = "smtp.office365.com";
        passwordCommand = "gpg -dq ${builtins.getEnv "HOME"}/.dswan@visionable.com-password.gpg";
        offlineimap = {
          enable = true;
          extraConfig.remote = {
            folderfilter = ''lambda folder: folder not in [
              'Calendar',
              'Calendar/Birthdays',
              'Calendar/IOCOM Holidays',
              'Calendar/United States holidays',
              'Contacts',
              'Contacts/Sub Folder 1',
              'Contacts/Sub Folder 2',
              'Contacts/Skype for Business Contacts',
              'Deleted Items',
              'Drafts',
              'Journal',
              'Junk Email',
              'Notes',
              'Outbox',
              'Sync Issues',
              'Sync Issues/Conflicts',
              'Sync Issues/Local Failures',
              'Sync Issues/Server Failures',
              'Tasks',
              'Tasks/Sub Folder 1',
              'Tasks/Sub Folder 2'
              ]
            '';
          };
        };

        msmtp.enable = true;
        signature = {
          text = ''
            Dustin Swan, Software Developer
            Visionable Ltd | https://visionable.com
            dswan@visionable.com
          '';
          showSignature = "append";
        };
      };
    };
  };

  programs.msmtp.enable = true;
  programs.offlineimap.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    # unimpaired endwise textobj-word-column MatchTag vim-matchmaker vim-vertical-move stdtabs matchit splitjoin vimade floaterm coc-nvim
    plugins = with pkgs.vimPlugins; [ nord-vim vim-airline vim-airline-themes vim-sensible vim-repeat vim-surround vim-fugitive vim-speeddating jdaddy-vim ale vim-snippets fzf-vim vim-tmux-navigator vim-multiple-cursors vim-easymotion vim-sneak nerdcommenter nerdtree emmet-vim undotree vim-signature vim-easy-align vim-better-whitespace vim-signify vim-expand-region vim-exchange argtextobj-vim goyo vim-orgmode vim-polyglot vim-devicons vim-startify ];
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

      let g:EasyMotion_smartcase = 1

      let g:coc_snippet_next = '<tab>'
      let g:coc_snippet_prev = '<S-Tab>'

      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#ale#enabled = 1
      let g:airline_powerline_fonts = 1

      let g:nord_italic = 1
      " let g:nord_italic_comments = 1
      let g:nord_underline = 1
      colorscheme nord

      nnoremap <silent><leader>p4 :! p4 edit %<cr>
      nnoremap <silent><leader>/ :noh<cr>
      nnoremap <leader>v <c-w>v<c-w>l
      nnoremap <leader>s <c-w>s<c-w>j
      nnoremap <leader>t :NERDTreeToggle<cr>
      nnoremap <leader>u :UndotreeToggle<cr>
      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)

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
    '';
  };

  programs.newsboat = {
    enable = true;
    extraConfig = ''
      urls-source "ttrss"
      ttrss-url "https://tt-rss.dustinswan.com/"
      ttrss-login "dustinswan"
      ttrss-passwordeval "gpg -dq ~/.dustinswan@tt-rss.dustinswan.com.gpg"
    '';
  };

  programs.bat.enable = true;
  programs.gpg.enable = true;
  programs.htop.enable = true;
  programs.mpv.enable = true;
  programs.jq.enable = true;
  programs.emacs.enable = true;
  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    inheritType = "any";
    agents = ["gpg" "ssh"];
    keys = ["id_rsa" "2B3A6377"];
  };
}
