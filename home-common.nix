{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat wget silver-searcher tree ranger nodejs yarn mu mosh newsboat msmtp w3m urlview nmap rtv gnupg youtube-dl nodePackages.tern nodePackages.eslint nodePackages.javascript-typescript-langserver nodePackages.js-beautify nodePackages.prettier nodePackages.dat
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "firefox";
    LEDGER_FILE = "~/Sync/Ledger/ledger.ledger";

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
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [ sensible resurrect pain-control continuum copycat open fzf-tmux-url maildir-counter yank ];
    # urlview
    extraConfig = ''
     set -g set-titles on
     set -g set-titles-string "#H (#S)"
     set -g status-right ""
     set -g status-left ""

     set-option -g mouse on
     set-option -g status-bg default
     set-option -g status-fg "#666666"
     set-option -g status-attr default
     set-option -g pane-border-fg "#666666"
     set-option -g pane-active-border-fg "#666666"
     set-option -g message-bg black
     set-option -g message-fg white
     set-option -g display-panes-active-colour white
     set-option -g display-panes-colour white

     set-window-option -g window-status-fg "#666666"
     set-window-option -g window-status-bg default
     set-window-option -g window-status-current-fg white
     set-window-option -g window-status-current-bg default
     set-window-option -g window-status-format " #W"
     set-window-option -g window-status-current-format " #W"
     set-window-option -g window-status-separator "  "
     set-window-option -g clock-mode-colour white

     set -g status-right 'FastMail: #{maildir_counter_1}, IOCOM: #{maildir_counter_2} | %a %Y-%m-%d %H:%M'

     set -g @maildir_counters '~/Mail/FastMail/INBOX/new|~/Mail/IOCOM/INBOX/new'

     # remove when tmux-plugin-navigator plugin is added
     is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
       | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
     tmux bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
     tmux bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
     tmux bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
     tmux bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
     tmux bind-key -n C-\\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"
     tmux bind-key -T copy-mode-vi C-h select-pane -L
     tmux bind-key -T copy-mode-vi C-j select-pane -D
     tmux bind-key -T copy-mode-vi C-k select-pane -U
     tmux bind-key -T copy-mode-vi C-l select-pane -R
     tmux bind-key -T copy-mode-vi C-\\ select-pane -l
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
    # for MacOS
    # initExtra = ''
    #   source ~/.nix-profile/etc/profile.d/nix.sh
    # '';
  };

  programs.fzf = {
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
        hostname = "dswan.visionable.com";
        user = "ec2-user";
      };

      visitest = {
        hostname = "visitest.iocom.com";
        user = "root";
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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    configure = {
      customRC = builtins.readFile ~/dotfiles/vimrc;
    };
  };

  programs.htop.enable = true;
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
