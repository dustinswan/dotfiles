{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep fd bat wget silver-searcher tree ranger nodejs yarn mosh newsboat msmtp w3m urlview nmap rtv gnupg youtube-dl nodePackages.tern nodePackages.eslint nodePackages.javascript-typescript-langserver nodePackages.js-beautify nodePackages.prettier ffmpeg ispell aspell hexyl nnn entr
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
    enable = true; # TODO
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    newSession = true;
    secureSocket = false;
    plugins = with pkgs.tmuxPlugins; [ sensible resurrect pain-control continuum copycat open urlview fzf-tmux-url yank vim-tmux-navigator ];
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
     # set-window-option -g clock-mode-colour white
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
    initExtra = ''
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
    accounts = {
      FastMail = {
        # name = "FastMail";
        address = "dustin@dustinswan.com";
        aliases = "dustinswan@gmail.com";
        primary = true;
        realName = "Dustin Swan";
        folders = {
          inbox = "INBOX";
          drafts = "INBOX.Drafts";
          sent = "INBOX.Sent";
          trash = "INBOX.Trash";
        };
        offlineimap = {
          enable = true;
          extraConfig.remote = {
            remotehost = "mail.messagingengine.com";
            remoteuser = "dustinswan@fastmail.com";
          };
        };
      };
    };

    maildirBasePath = "\$HOME/Mail";
  };

  # programs.offlineimap.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = builtins.readFile ~/dotfiles/vimrc;
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
