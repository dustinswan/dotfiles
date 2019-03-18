{ pkgs, ... }:

{
  home.packages = with pkgs; [ bat beets wget clipit keychain ncmpcpp pandoc silver-searcher tmux tree unzip wirelesstools xcape xclip anki pavucontrol ranger blueman gifsicle networkmanager paprefs steam mpv nnn nodejs pinentry vlc gnupg nitrogen alacritty wine tldr yarn spotify signal-desktop mu mosh ispell google-chrome emacs-all-the-icons-fonts gnupg python3 veracrypt bashmount exfat exfat-utils neofetch toot rtv newsboat neomutt i3lock-pixeled nmap p4v killall calc cargo cava diceware magic-wormhole msmtp xorg.xmodmap zip youtube-dl cacert dropbox-cli keepassx2 w3m wireshark-qt khard khal vdirsyncer slack riot-web retroarch ipfs gimp blender
  ];

  home.sessionVariables = {
    P4USER = "dswan";
    P4PORT = "humu.iocom.com:1666";
    P4CONFIG = "p4.cfg";
    P4EDITOR = "nvim";
    P4IGNORE = ".ignore";
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/home/dustinswan/Music";
    playlistDirectory = "/home/dustinswan/Music/Playlists";
  };

  services.syncthing = {
    enable = true;
    tray = true;
  };

  services.compton = {
    enable = true;
    inactiveOpacity = "0.90";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    maxCacheTtlSsh = 86400;
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      mpdSupport = true;
      alsaSupport = true;
    };
    config = ~/dotfiles/polybar;
    script = "PATH=$PATH:${pkgs.i3-gaps}/bin polybar top &";
  };

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.i3lock-pixeled}/bin/i3lock-pixeled";
  };

  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.numix-icon-theme;
      name = "Numix";
      size = "32";
    };
    settings = {
      global = {
        geometry = "300x5-30+50";
        padding = 12;
        horizontal_padding = 12;
        transparency = 10;
        frame_color = "#66aaff";
        frame_width = 2;
        font = "Iosevka Nerd Font Regular 9";
        markup = "full";
        word_wrap = true;
        format = "<b>%s</b> \n %b";
        icon_position = "left";

        background = "#000000";
        foreground = "#dddddd";
      };

      urgency_low = {
        background = "#000000";
        foreground = "#dddddd";
      };

      urgency_normal = {
        background = "#000000";
        foreground = "#dddddd";
      };

      urgency_critical = {
        foreground = "#eceff1";
        background = "#bd2c40";
        frame_color = "#9b0a20";
      };
    };
  };
  # services.udiskie.enable = true;
  services.unclutter.enable = true;
  # services.keepassx.enable = true;
  services.flameshot.enable = true;
  services.keybase.enable = true;
  services.pasystray.enable = true;
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
  services.emacs.enable = true;

  programs.home-manager.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.vscode.enable = true;
  programs.fish = {
    enable = true;
    # interactiveShellInit = builtins.readFile ~/dotfiles/config.fish;
    shellAliases = {
      l = "ls -la";
      ta = "tmux attach -d";
      e = "emacsclient -a \"\" -t -nw";
      weather = "curl http://wttr.in";
    };
  };
  programs.firefox.enable = true;
  programs.fzf.enable = true;
  programs.feh.enable = true;
  programs.git = {
    enable = true;
    userName = "Dustin Swan";
    userEmail = "dustin@dustinswan.com";
  };
  programs.emacs.enable = true;
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
  programs.keychain = {
    enable = true;
    inheritType = "any";
    agents = ["gpg" "ssh"];
    keys = ["id_rsa" "2B3A6377"];
  };
  programs.rofi = {
    enable = true;
  };

  xsession = {
    enable = true;
    profileExtra = builtins.readFile ~/dotfiles/xprofile;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        bars = [];
        startup = [{
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }];
      };
      extraConfig = builtins.readFile ~/dotfiles/i3;
    };
  };
}
