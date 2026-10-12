{ pkgs, ... }:

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
    fd
    ddev
    ngrok
    mkcert
    gnupg
    cacert
    # Language toolchains live per project (shell.nix + .envrc via direnv);
    # only what's needed to edit this repo and nvim's config stays global.
    nixd
    lua-language-server
    tree-sitter
    comma # , cmd args: run any nixpkgs command without installing it
    dict
    ispell
    aspell
    aspellDicts.en
    aspellDicts.fr
    aspellDicts.de
    aspellDicts.eo
    aspellDicts.es
  ];

  home.sessionVariables.EDITOR = "vim";

  home.sessionPath = [ "$HOME/.local/bin" ];

  xdg.enable = true;

  programs.home-manager.enable = true;

  programs.nix-index.enable = true;

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
    ];

    interactiveShellInit = "set fish_greeting";
  };

  programs.nix-your-shell.enable = true;
  programs.direnv.enable = true;
  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "ansi";
  };
  programs.ripgrep.enable = true;
  programs.ripgrep-all.enable = true;

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
    settings."*".AddKeysToAgent = "yes";
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
    ignores = [ ".direnv/" "**/.claude/settings.local.json" ];
  };
  programs.gh.enable = true;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  # programs.gitui.enable = true;

  programs.gpg.enable = true;

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    initLua = builtins.readFile ./init.lua;
    extraPackages = [ pkgs.gcc ];
  };
}
