{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  home.stateVersion = "26.05";

  home.username = "dustinswan";
  home.shell.enableShellIntegration = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.packages = with pkgs; [
    supabase-cli
    bitwarden-cli
    awscli2
    # claude-code # using the native installer instead (~/.local/bin, needs programs.nix-ld)
    # claude-code-acp
    # opencode # see also: aider; toad;
    fd
    # poppler-utils # pdftotext
    # xan # e.g. xan slice 3,2 file.csv | xan behead | xan view -An; see also: csvi
    # doxx # read docx files
    # sqlit-tui # see also: pam; harlequin; lazysql; gobang; dblab
    # snitch # see also: bandwhich
    # epy # ebook reader. see also: erp; bookokrat; lue
    # mimic # tts engine, used by epy
    # posting # see also: httpie, yapi, sled, Yaak (GUI), Bruno (GUI)
    # croc magic-wormhole # transfer files
    # calcure # calendar cli app, can point to ics files or URL
    # dust duf dua # disk usage. see also: cull
    # doggo # dig
    ddev
    ngrok
    mkcert
    yt-dlp
    # ffmpeg
    gnupg
    cacert
    nodejs
    typescript
    bun
    pnpm
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer
    uv
    blade-formatter
    nixd # Nix language server
    comma
    typescript-language-server
    stylelint
    js-beautify
    intelephense
    vscode-langservers-extracted
    elixir-ls
    lua-language-server
    tree-sitter
    dict
    ispell
    aspell
    aspellDicts.en
    aspellDicts.fr
    aspellDicts.de
    aspellDicts.eo
    aspellDicts.es
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "open";
    inherit (secrets.gemini) GOOGLE_CLOUD_PROJECT;
    inherit (secrets.anthropic) CLAUDE_CODE_OAUTH_TOKEN;
  };

  home.sessionPath = [
    "$HOME/.cache/.bun/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.npm-global/bin"
    "/opt/homebrew/bin"
  ];

  xdg.enable = true;

  programs.home-manager.enable = true;

  programs.nix-index.enable = true;

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
      # extrakto # prefix tab -> fuzzy find text on screen; enter to copy; tab to paste
      # fingers # prefix F -> copy/open/edit items on screen by letter
    ];
    # Remove that SHELL thing when fixed upstream
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g default-command "$SHELL"

      # Status bar - inherits terminal fg/bg so it follows light/dark mode
      set -g status-style "bg=default,fg=default"
      set -g status-justify centre
      set -g status-left ""
      set -g status-right ""
      set -g window-status-format "  #I  "
      set -g window-status-current-format "  #I  "
      set -g window-status-current-style "bold,reverse"
      set -g window-status-style "dim"

      # Pane borders
      set -g pane-border-style "fg=brightblack"
      set -g pane-active-border-style "fg=white"

      # Messages
      set -g message-style "bg=default,fg=default,bold"
    '';
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      nrs = "sudo nixos-rebuild switch";
      nrsu = "sudo nixos-rebuild switch --upgrade";
      hms = "home-manager switch";
    };
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

    interactiveShellInit = "set fish_greeting";
  };

  programs.nix-your-shell.enable = true;
  programs.direnv.enable = true;
  programs.starship.enable = true;
  programs.nix-search-tv.enable = true;
  programs.fzf.enable = true; # used by other apps, tmux, etc.
  programs.zoxide.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "ansi";
  };
  programs.ripgrep.enable = true;
  programs.ripgrep-all.enable = true;
  programs.yazi.enable = true;

  programs.eza = {
    enable = true;
    git = true;
  };

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # TODO: remove when defaults change
    settings = {
      dustinswan = {
        User = secrets.dustinswan.user;
        HostName = secrets.dustinswan.hostname;
      };
    };
  };

  programs.git = {
    enable = true;
    signing = {
      signByDefault = true;
      key = "30D46587E2100467";
    };
    settings = {
      push.autoSetupRemote = true;
      user.email = "dustin@dustinswan.com";
      user.name = "Dustin Swan";
    };
  };
  programs.gh.enable = true;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.gitui.enable = true;

  programs.gpg.enable = true;

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
  };

  programs.keychain = {
    enable = true;
    keys = (secrets.sshKeys or [ ]) ++ [ "2B3A6377" ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    initLua = builtins.readFile ./init.lua;
  };
}
