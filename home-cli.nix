{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  home.stateVersion = "18.09";

  home.packages = with pkgs; [
    ripgrep
    fd
    mosh
    w3m
    nnn
    hexyl
    wget
    httpie
    nmap
    timg
    sox
    du-dust
    restic
    bitwarden-cli
    gnupg
    gpg-tui
    rage
    sd
    libqalculate
    glow
    spotify-tui
    spotifyd
    amfora
    duf
    pandoc
    pastel
    jq
    jo
    fx
    jc
    miller
    sc-im
    cacert
    weechat
    ddgr
    visidata
    magic-wormhole
    nixfmt
    shellcheck
    vale
    tectonic
    zathura # lilypond-with-fonts
    nodejs
    deno
    yarn
    nodePackages.typescript-language-server
    nodePackages.stylelint
    nodePackages.js-beautify
    nodePackages.expo-cli
    ocaml
    dune_2
    ocamlPackages.utop
    ocamlPackages.ocp-indent
    ocamlPackages.merlin
    rustup
    go
    cmake
    racket-minimal
    # ghc haskell-language-server hlint haskellPackages.hoogle
    lua53Packages.luarocks
    translate-shell
    ispell
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.fr
    aspellDicts.de
    aspellDicts.eo
    aspellDicts.es
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "open";
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
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect # prefix ctrl-s to save sessions; prefix ctrl-r to restore
      continuum # automatically save the session every 15 minutes
      sessionist # prefix g to switch sessions; prefix C to create; prefix X to kill; prefix S to switch back; prefix @ to promote; prefix t f to join marked pane
      pain-control # prefix |, -, \, _ to split; prefix h, j, k, l to switch; prefix H, J, K, L to resize; prefix <, > to move windows
      fzf-tmux-url # prefix u -> fzf urls
      yank # prefix y -> copy command line to clipboard; prefix Y -> copy pwd to clipboard; search + y -> copy to clipboard
      open # highlight: o -> open; ctrl-o -> $EDITOR; S -> web search
      vim-tmux-navigator # ctrl-h, -j, -k, -l -> move between tmux and vim splits
      extrakto # prefix tab -> fuzzy find text on screen; enter to copy; tab to paste 
    ];
    extraConfig = ''
      set -g mouse on
      set -g status-right ""
      set -g status-left ""
      set -g status-style fg=white
      set-window-option -g window-status-format '#[fg=cyan,bright,dim]#I #[fg=white,bright,dim]#W '
      set-window-option -g window-status-current-format '#[fg=cyan,bright,nodim]#I #[fg=white,bright,nodim]#W '
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.zoxide = {
    # z doc -> cd ~/Documents; zi -> interactive
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "httpie" "aws" "fd" "fzf" "mosh" "npm" "ripgrep" "rsync" "sudo" "yarn" "vi-mode" ];
    };
    shellAliases = {
      v = "vi";
      l = "exa -lah --icons --git";
      n = "nnn";
      h = "himalaya";
      er = "rm -rf logs; unzip -o";
      srsync = "rsync --rsync-path='sudo rsync'";
      ambient1 = "play -n -c1 synth whitenoise lowpass -1 120 lowpass -1 120 lowpass -1 120 gain +16";
      ambient2 = "play -c 2 -n synth brownnoise lowpass 200";
      ambient3 = "play -c 2 -n synth brownnoise lowpass 150 loudness +10";
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      v = "vi";
      l = "exa -lah --icons --git";
      n = "nnn";
      h = "himalaya";
      er = "rm -rf logs; unzip -o";
      srsync = "rsync --rsync-path='sudo rsync'";
      ambient1 = "play -n -c1 synth whitenoise lowpass -1 120 lowpass -1 120 lowpass -1 120 gain +16";
      ambient2 = "play -c 2 -n synth brownnoise lowpass 200";
      ambient3 = "play -c 2 -n synth brownnoise lowpass 150 loudness +10";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    # enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    # ctrl-t, ctrl-r, ssh **<tab>
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type file --color=always";
    defaultOptions = [
      "--height 40%"
      "--border"
      "--ansi"
      "--color bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD"
      "--color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96"
      "--color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
    ];

    fileWidgetCommand = "fd --type file --color=always";
    fileWidgetOptions = [ "--min-height 30 --preview-window noborder --preview '(bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}) 2> /dev/null'" ];
  };

  programs.navi = {
    # ctrl-G
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
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
    aliases = {
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    delta = {
      enable = true;
      options = {
        syntax-theme = "Nord";
      };
    };
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };

  programs.gh.enable = true;

  programs.lazygit.enable = true;

  programs.gitui = {
    enable = true;
    keyConfig = ''(
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

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        cursorline = true;
        lsp.display-messages = true;
        indent-guides.render = true;
      };
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
  # xdg.configFile."nvim/lua/plugins/lazyvim-plugins.lua".source = ./lazyvim-plugins.lua;

  programs.bat = {
    enable = true;
    themes = {
      Catppuccin-mocha = builtins.readFile (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        } + "/Catppuccin-mocha.tmTheme");
    };
    config = {
      theme = "Catppuccin-mocha";
    };
  };

  programs.gpg.enable = true;
  programs.mpv.enable = true;
  programs.noti.enable = true;
  programs.btop.enable = true;
  programs.tealdeer.enable = true;

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    inheritType = "any";
    agents = [ "gpg" "ssh" ];
    keys = [ "id_rsa" "2B3A6377" ];
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
}
