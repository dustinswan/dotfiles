{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ bat wget clipit ncmpcpp pandoc silver-searcher tree unzip wirelesstools xcape xsel anki pavucontrol ranger blueman gifsicle networkmanager paprefs steam mpv nnn nodejs pinentry vlc gnupg nitrogen alacritty wine tldr yarn spotify signal-desktop mu mosh ispell google-chrome emacs-all-the-icons-fonts gnupg python3 python37Packages.pip veracrypt bashmount exfat exfat-utils neofetch toot rtv newsboat neomutt i3lock-pixeled nmap p4v killall calc cargo cava diceware magic-wormhole msmtp xorg.xmodmap zip youtube-dl cacert dropbox-cli keepassx2 w3m wireshark-qt khard khal vdirsyncer slack riot-web retroarch ipfs gimp blender urlview
  ];

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
    extraConfig = ''
      pinentry-program /home/dustinswan/.nix-profile/bin/pinentry
    '';
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
    inactiveInterval = 30;
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

  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.vscode.enable = true;
  programs.firefox.enable = true;
  programs.feh.enable = true;
  programs.emacs.enable = true;
  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    inheritType = "any";
    agents = ["gpg" "ssh"];
    keys = ["id_rsa" "2B3A6377"];
    # extraFlags = "--quiet";
  };
  programs.rofi = {
    enable = true;
  };
  programs.beets = {
    enable = true;
    settings = {
      directory = "~/Music";
      library = "~/Music/musiclibrary.db";
      import = {
        copy = true;
      };
      plugins = [ "lastgenre" "fetchart" "embedart" "lyrics" "scrub" "mpdupdate" ]; # TODO bandcamp
      lastfm = {
        user = "dustinswan";
      };
      bandcamp = {
        lyrics = true;
        art = true;
      };
    };
  };

  xsession = {
    enable = true;
    profileExtra = builtins.readFile ~/dotfiles/xprofile;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod4";
        gaps = {
          inner = 10;
          outer = 0;
          smartBorders = "on";
        };
        window = {
          border = 0;
          commands = [
            { criteria = { class = "mpv"; }; command = "floating enable, move absolute position center"; }
            { criteria = { class = "feh"; }; command = "floating enable, move absolute position center"; }
          ];
        };
        bars = [];
        startup = [{
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }];
        keybindings = let mod = "Mod4"; in lib.mkOptionDefault {
          "${mod}+space" = "exec \"rofi -show combi\"";
          "${mod}+Return" = "exec alacritty";
          "${mod}+Ctrl+Mod1+t" = "exec alacritty";
          "${mod}+Ctrl+Mod1+e" = "exec \"emacsclient -c\"";
          "${mod}+Ctrl+Mod1+b" = "exec firefox";
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+s" = "layout stacking";
          "${mod}+comma" = "layout tabbed";
          "${mod}+period" = "layout toggle split";

          "${mod}+apostrophe" = "split h";
          "${mod}+minus" = "split v";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+Ctrl+space" = "focus mode_toggle";

          "${mod}+p" = "focus parent";
          "${mod}+c" = "focus child";
          "${mod}+r" = "mode resize";
        };
      };
      # extraConfig = builtins.readFile ~/dotfiles/i3;
    };
  };

  imports = [ ./home-common.nix ];
}
