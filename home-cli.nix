{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
  nixvim = import (builtins.fetchGit { url = "https://github.com/nix-community/nixvim"; });
in
{
  home.stateVersion = "24.11";

  home.username = "dustinswan";
  home.homeDirectory = "/Users/dustinswan";
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

  # Remove when bitwarden-cli is fixed upstream
  # https://github.com/NixOS/nixpkgs/issues/339576#issuecomment-2574076670
  nixpkgs.overlays = [
    (final: prev: { bitwarden-cli = prev.bitwarden-cli.overrideAttrs (oldAttrs: { nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ prev.llvmPackages_18.stdenv.cc ]; stdenv = prev.llvmPackages_18.stdenv; }); })
  ];

  home.packages = with pkgs; [
    supabase-cli
    bitwarden-cli
    awscli2
    claude-code
    opencode
    fd
    poppler-utils
    xan # e.g. xan slice 3,2 file.csv | xan behead | xan view -An
    ngrok
    ddev
    mkcert
    gnupg
    cacert
    nodejs
    typescript
    pnpm
    rustc
    cargo
    uv
    blade-formatter
    nil
    nixd
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
    inherit (secrets.gemini) GEMINI_API_KEY;
    inherit (secrets.gemini) GOOGLE_CLOUD_PROJECT;
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

    # https://codeberg.org/adamcstephens/dotfiles/src/commit/e14f35f6e9a9cb9174016948c512c0db364e0dec/apps/fish/init.fish
    shellInit = ''
      fenv source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      source /nix/var/nix/profiles/default/etc/profile.d/nix.fish
    '';
  };

  programs.direnv.enable = true;
  programs.starship.enable = true;
  # programs.television.enable = true; # WAIT config currently broken
  programs.fzf.enable = true; # used by other apps, tmux, etc.
  programs.zoxide.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
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
    userName = "Dustin Swan";
    userEmail = "dustin@dustinswan.com";
    signing = {
      signByDefault = true;
      key = "AD11750151C10881970BD943AB49BD6B2B3A6377";
    };
    delta.enable = true;
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };

  programs.gitui.enable = true;

  programs.gpg.enable = true;

  programs.keychain = {
    enable = true;
    keys = [ "id_rsa" "id_rsa_mr" "2B3A6377" ];
  };
}
