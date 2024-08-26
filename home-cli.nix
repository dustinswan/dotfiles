{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  home.stateVersion = "18.09";

  home.username = "dustinswan";
  home.homeDirectory = "/Users/dustinswan";

  imports = [
    <catppuccin/modules/home-manager>
  ];

  home.packages = with pkgs; [
    fd # `fd PATTERN`; `fd` is like ls-R; `-e ext` searches by extension; `-g` for glob; `-H` searches hidden files; `-u` for unrestricted; `fd -e jpg -x convert {} {.}.png`
    mosh # like ssh but better on spotty networks
    w3m
    wget
    httpie
    ngrok
    ddev
    bitwarden-cli
    mkcert
    gnupg
    rage
    sd
    cacert
    weechat
    sttr # string operations. e.g. sttr md5 "Hello World"; sttr snake "ChangeCase"
    imagemagick
    # visidata
    magic-wormhole
    termscp # SCP/SFTP/FTP/S3
    nodejs
    pipx
    yarn
    php83
    stack
    ruby
    # haskellPackages.ghcup
    php83Packages.composer
    nodePackages.typescript-language-server
    nodePackages.stylelint
    nodePackages.js-beautify
    nodePackages.intelephense
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
    inherit (secrets.openai) OPENAI_API_KEY;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.npm-global/bin"
  ];

  xdg.enable = true;

  programs.home-manager.enable = true;

  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
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
      # open # highlight: o -> open; ctrl-o -> $EDITOR; S -> web search
      vim-tmux-navigator # ctrl-h, -j, -k, -l -> move between tmux and vim splits
      extrakto # prefix tab -> fuzzy find text on screen; enter to copy; tab to paste 
      fingers # prefix F -> copy/open/edit items on screen by letter
    ];
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
    catppuccin.enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };

  programs.zoxide = {
    # z doc -> cd ~/Documents; zi -> interactive
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "httpie" "aws" "fzf" "mosh" "npm" "rsync" "sudo" "yarn" "vi-mode" ];
    };
    syntaxHighlighting.catppuccin.enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    catppuccin.enable = true;
  };

  programs.fzf = {
    # ctrl-t, ctrl-r, ssh **<tab>
    enable = true;
    enableZshIntegration = true;
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
    catppuccin.enable = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      dustinswan = {
        inherit (secrets.dustinswan) user;
        inherit (secrets.dustinswan) hostname;
      };

      mr = {
        inherit (secrets.mr) user;
        inherit (secrets.mr) hostname;
        identityFile = "/Users/dustinswan/.ssh/id_rsa_mr";
        identitiesOnly = true;
      };

      mr-prod = {
        inherit (secrets.mr-prod) user;
        inherit (secrets.mr-prod) hostname;
        identityFile = "/Users/dustinswan/.ssh/id_rsa_mr";
        identitiesOnly = true;
      };

      mr-prod2 = {
        inherit (secrets.mr-prod2) user;
        inherit (secrets.mr-prod2) hostname;
        identityFile = "/Users/dustinswan/.ssh/id_rsa_mr";
        identitiesOnly = true;
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
    delta = {
      enable = true;
      catppuccin.enable = true;
    };
  };

  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.gitui = {
    enable = true;
    catppuccin.enable = true;
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
    catppuccin.enable = true;
  };

  programs.gpg.enable = true;
  programs.tealdeer.enable = true;
  programs.ripgrep.enable = true;

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    inheritType = "any";
    agents = [ "gpg" "ssh" ];
    keys = [ "id_rsa" "id_rsa_mr" "2B3A6377" ];
  };
}
