{ pkgs, ... }:

let
  secrets = import ./secrets.nix;

  doom-emacs = pkgs.callPackage
    (builtins.fetchTarball {
      url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
    })
    {
      doomPrivateDir = ./doom;
    };
in
{
  home.packages = with pkgs; [
    ripgrep
    fd
    wget
    mosh
    w3m
    urlview
    hexyl
    httpie
    timg
    tealdeer
    du-dust
    duplicati
    bitwarden-cli
    gnupg
    gpg-tui
    rage
    sd
    eva
    glow
    restic
    gitui
    spotify-tui
    slides
    manix
    amfora
    weechat
    duf
    procs
    pandoc
    magic-wormhole
    qrcp
    pastel
    jo # jo name=Dustin age=99 -> { name: "dustin", age: 99 }
    fx # jo -a one two three | fx ".map(e => e.length > 3)"  -> [false, false, true]
    visidata
    bandwhich
    nodejs
    deno
    yarn
    nodePackages.typescript-language-server
    nodePackages.stylelint
    nodePackages.js-beautify
    ocaml
    dune_2
    ocamlPackages.utop
    ocamlPackages.ocp-indent
    ocamlPackages.merlin
    # racket-minimal
    rustc
    ghc
    cargo
    go
    cmake
    haskell-language-server
    hlint
    haskellPackages.hoogle # haskellPackages.cabal
    nixfmt
    shellcheck
    fontconfig
    cmigemo
    cacert
    emacsPackages.fontawesome
    emacs-all-the-icons-fonts
    ispell
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.fr
    aspellDicts.de
    aspellDicts.eo
    aspellDicts.es
    doom-emacs
    code-minimap
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROSWER = "open";
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
      resurrect
      sensible
      pain-control # prefix |, -, \, _ to split; prefix h, j, k, l to switch; prefix H, J, K, L to resize; prefix <, > to move
      fzf-tmux-url # prefix u -> fzf urls
      yank # prefix y -> copy command line to clipboard; prefix Y -> copy pwd to clipboard; search + y -> copy to clipboard
      open # highlight: o -> open; ctrl-o -> $EDITOR; S -> web search
      # vim-tmux-navigator # ctrl-h, -j, -k, -l -> move between tmux and vim splits # TODO doesn't work with helix
    ];
    # set -g set-titles on
    # set -g set-titles-string "#H (#S)"
    extraConfig = ''
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

  programs.zoxide = {
    # z doc -> cd ~/Documents; zi -> interactive
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
      vim = "~/.local/bin/lvim"; # trying out LunarVim
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

  programs.fzf = {
    # ctrl-t, ctrl-r, ssh **<tab>
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type file --color=always";
    defaultOptions = [ "--height 40%" "--border" "--ansi" ];
    fileWidgetCommand = "fd --type file --color=always";
    fileWidgetOptions = [ "--min-height 30 --preview-window noborder --preview '(bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}) 2> /dev/null'" ];
  };

  programs.navi = {
    # ctrl-G
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
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "nord";
      lsp.display-messages = true;
      keys.normal = {
        C-h = "jump_view_left";
        C-l = "jump_view_right";
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
  };

  home.file.lunarVim = {
    target = ".config/lvim/config.lua";
    source = ./lunar.lua;
  };

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
}
