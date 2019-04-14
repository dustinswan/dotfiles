{ pkgs, ... }:

{
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

  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    baseIndex = 1;
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [ sensible resurrect pain-control continuum copycat open urlview yank ];
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
      ta = "tmux attach -d";
      e = "emacsclient -a \"\" -t -nw";
      weather = "curl http://wttr.in";
      er = "rm -rf logs; unzip -o";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      visionable = {
        hostname = "dswan.visionable.com";
        user = "ec2-user";
      };

      dswan = {
        hostname = "dswan.iocom.com";
        user = "root";
      };

      dustinswan = {
        hostname = "dustinswan.com";
        user = "dustinswan";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Dustin Swan";
    userEmail = "dustin@dustinswan.com";
    signing = {
      signByDefault = true;
      key = "2B3A6377";
    };
    aliases = {
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
}
