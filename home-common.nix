{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep fd bat wget silver-searcher tree ranger nodejs yarn mosh msmtp w3m urlview nmap rtv gnupg youtube-dl nodePackages.tern nodePackages.eslint nodePackages.javascript-typescript-langserver nodePackages.js-beautify nodePackages.prettier ffmpeg ispell aspell hexyl nnn entr httpie cacert
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "firefox";

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
    initExtra = '' # for MacOS
      source ~/.nix-profile/etc/profile.d/nix.sh
    '';
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
    certificatesFile = "/Users/dustinswan/.nix-profile/etc/ssl/certs/ca-bundle.crt"; # TODO NIX_SSL_CERT_FILE

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
        passwordCommand = "gpg -dq ~/.dustinswan@fastmail.com-password.gpg";
        offlineimap.enable = true;
      };

      IOCOM = {
        address = "dswan@iocom.com";
        aliases = "dswan@visionable.com";
        realName = "Dustin Swan";
        folders = {
          inbox = "INBOX";
          drafts = "Drafts";
          sent = "Sent Items";
          trash = "Deleted Items";
        };
        userName = "dswan@iocom.com";
        imap.host = "secure.emailsrvr.com";
        smtp.host = "secure.emailsrvr.com";
        passwordCommand = "gpg -dq ~/.iocom-password.gpg";
        offlineimap.enable = true;
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
    extraConfig = builtins.readFile ~/dotfiles/vimrc;
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
