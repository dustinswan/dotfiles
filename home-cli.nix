{ pkgs, ... }:

{
  _module.args.machine = rec {
    isWork = builtins.pathExists ./secrets-majorrocket.nix;
    isPersonal = !isWork;
  };

  home.stateVersion = "26.05";

  home.username = "dustinswan";
  home.shell.enableShellIntegration = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      options = "-d";
    };
  };

  home.packages = with pkgs; [
    comma
  ];

  home.sessionVariables.EDITOR = "vim";

  home.sessionPath = [ "$HOME/.local/bin" ];

  xdg.enable = true;

  programs.home-manager.enable = true;

  programs.nix-index.enable = true;

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];

    functions.update = ''
      if command -q brew
        brew update; or return
        if test -e ~/.config/homebrew/Brewfile
          brew bundle --global; or return
        end
        brew upgrade; and brew cleanup --prune=all
      end
      sudo nix-channel --update
      nix-channel --update
      if test -e /etc/NIXOS
        sudo nixos-rebuild switch; or return
      end
      home-manager switch
    '';

    interactiveShellInit = "set fish_greeting";
  };

  programs.nix-your-shell.enable = true;
  programs.direnv = {
    enable = true;
    config.global.hide_env_diff = true;
  };
  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.bat.enable = true;
  programs.fd.enable = true;
  programs.awscli.enable = true;
  programs.ripgrep.enable = true;
  programs.ripgrep-all.enable = true;
  programs.eza.enable = true;

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
    extraPackages = with pkgs; [ gcc tree-sitter nixd lua-language-server copilot-language-server ];
  };
}
