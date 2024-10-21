{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
  nixvim = import (builtins.fetchGit { url = "https://github.com/nix-community/nixvim"; });
in
{
  home.stateVersion = "18.09";

  home.username = "dustinswan";
  home.homeDirectory = "/Users/dustinswan";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  imports = [
    <catppuccin/modules/home-manager>
    nixvim.homeManagerModules.nixvim
    ./home-nvim.nix
  ];

  home.packages = with pkgs; [
    fd # `fd PATTERN`; `fd` is like ls-R; `-e ext` searches by extension; `-g` for glob; `-H` searches hidden files; `-u` for unrestricted; `fd -e jpg -x convert {} {.}.png`
    mosh # like ssh but better on spotty networks
    aider-chat
    w3m
    wget
    httpie # HTTPie CLI — modern, user-friendly command-line HTTP client for the API era. JSON support, colors, sessions, downloads, plugins & more
    monolith # CLI tool for saving complete web pages as a single HTML file
    supabase-cli
    ngrok
    ddev
    # bitwarden-cli
    mkcert
    gnupg
    gitu # A TUI Git client inspired by Magit
    rage # A simple, secure and modern file encryption tool (and Rust library) with small explicit keys, no config options, and UNIX-style composability
    sd
    jq
    sq
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
    # php83
    stack
    cargo
    ruby
    llvm
    blade-formatter
    # haskellPackages.ghcup
    # php83Packages.composer
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
    "/opt/homebrew/bin"
    "/Users/dustinswan/Downloads/roc_nightly-macos_apple_silicon-2024-10-09-bf5b13e237f"
  ];

  xdg.enable = true;

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

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
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "httpie" "aws" "mosh" "npm" "rsync" "sudo" "yarn" "vi-mode" ];
    };
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
          sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
      }
    ];

    # https://codeberg.org/adamcstephens/dotfiles/src/commit/e14f35f6e9a9cb9174016948c512c0db364e0dec/apps/fish/init.fish
    shellInit = ''
      fenv source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      source /nix/var/nix/profiles/default/etc/profile.d/nix.fish
    '';
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

  # programs.skim = {
  #   enable = true;
  #   enableFishIntegration = true;
  #   enableZshIntegration = true;
  # };
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
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
      signByDefault = true;
      key = "AD11750151C10881970BD943AB49BD6B2B3A6377";
    };
    delta.enable = true;
  };

  programs.lazygit.enable = true;
  programs.gitui.enable = true;

  programs.bat.enable = true; 
  programs.gpg.enable = true;
  programs.tealdeer.enable = true;
  programs.ripgrep.enable = true;

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    inheritType = "any";
    agents = [ "gpg" "ssh" ];
    keys = [ "id_rsa" "id_rsa_mr" "2B3A6377" ];
  };
}
