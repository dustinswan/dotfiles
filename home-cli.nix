{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
  nixvim = import (builtins.fetchGit { url = "https://github.com/nix-community/nixvim"; });
in
{
  home.stateVersion = "24.11";

  home.username = "dustinswan";
  home.shell.enableShellIntegration = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  imports = [
    <catppuccin/modules/home-manager>
    nixvim.homeModules.nixvim
    ./home-nvim.nix
  ];

  home.packages = with pkgs; [
    supabase-cli
    bitwarden-cli
    awscli2
    claude-code
    claude-code-acp
    opencode # see also: aider; toad;
    fd
    poppler-utils # pdftotext
    xan # e.g. xan slice 3,2 file.csv | xan behead | xan view -An; see also: csvi
    doxx # read docx files
    sqlit-tui # see also: harlequin; lazysql; gobang; dblab
    # snitch # see also: bandwhich
    epy # ebook reader. see also: erp; bookokrat; lue
    # mimic # tts engine, used by epy
    posting # see also: httpie, yapi, sled, Yaak (GUI), Bruno (GUI)
    croc magic-wormhole # transfer files
    # calcure # calendar cli app, can point to ics files or URL
    dust duf dua # disk usage
    doggo # dig
    ddev
    ngrok
    mkcert
    ffmpeg
    gnupg
    cacert
    nodejs
    typescript
    pnpm
    rustc
    cargo
    uv
    blade-formatter
    nixd # Nix language server
    nodePackages.typescript-language-server
    nodePackages.stylelint
    nodePackages.js-beautify
    nodePackages.intelephense
    dict
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
    inherit (secrets.gemini) GEMINI_API_KEY;
    inherit (secrets.gemini) GOOGLE_CLOUD_PROJECT;
    inherit (secrets.anthropic) CLAUDE_CODE_OAUTH_TOKEN;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.npm-global/bin"
    "/opt/homebrew/bin"
  ];

  xdg.enable = true;

  catppuccin = {
    enable = true;
    flavor = "mocha";
    zed.enable = false;
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
      # extrakto # prefix tab -> fuzzy find text on screen; enter to copy; tab to paste
      fingers # prefix F -> copy/open/edit items on screen by letter
    ];
    # Remove that SHELL thing when fixed upstream
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g default-command "$SHELL"
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
  programs.television.enable = true; # WAIT config currently broken
  programs.nix-search-tv.enable = true;
  # programs.fzf.enable = true; # used by other apps, tmux, etc.
  programs.zoxide.enable = true;
  programs.bat.enable = true;
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

  # programs.intelli-shell.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # TODO: remove when defaults change
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

      mr-prod3 = {
        inherit (secrets.mr-prod3) user;
        inherit (secrets.mr-prod3) hostname;
        identityFile = "/Users/dustinswan/.ssh/id_rsa_mr";
        identitiesOnly = true;
      };

      mr-prod4 = {
        inherit (secrets.mr-prod4) user;
        inherit (secrets.mr-prod4) hostname;
        identityFile = "/Users/dustinswan/.ssh/id_rsa_mr";
        identitiesOnly = true;
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
    keys = [ "id_rsa" "id_rsa_mr" "2B3A6377" ];
  };
}
