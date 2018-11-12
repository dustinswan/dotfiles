# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vpn.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.plymouth.enable = true;
  boot.plymouth.theme = "fade-in";
  boot.plymouth.logo = pkgs.fetchurl {
    url = "https://nixos.org/logo/nixos-hires.png";
    sha256 = "1ivzgd7iz0i06y36p8m5w48fd8pjqwxhdaavc0pxs7w1g7mcy5si";
  };

  networking = {
    hostName = "sw4n";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
  };

  networking.firewall.allowedTCPPorts = [ 24800 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    # consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";

    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ anthy mozc ];
    };
  };

  time.timeZone = "US/Eastern";

  environment.systemPackages = with pkgs; [
    wget vim clipit compton feh firefox fzf git gparted gucharmap htop keepass keepassx2 keychain ncmpcpp neovim pandoc polybar qutebrowser rofi silver-searcher tmux tree unzip wirelesstools xcape xclip anki pavucontrol ranger blueman gifsicle networkmanager paprefs steam xscreensaver hledger hledger-web ledger mpv nnn nodejs pinentry vlc gnupg nitrogen alacritty wine tldr yarn spotify signal-desktop mu mosh ispell google-chrome emacs-all-the-icons-fonts gnupg python udiskie veracrypt bashmount exfat exfat-utils neofetch w3m toot rtv newsboat neomutt dunst
  ];

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
        mpdSupport = true;
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services = {
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    transmission = {
      enable = true;
    };

    mopidy = {
      enable = true;
      extensionPackages = [ pkgs.mopidy-spotify pkgs.mopidy-youtube pkgs.mopidy-iris ];
      configuration = ''
        [audio]
        output = pulsesink server=127.0.0.1

        [local]
        enabled = true
        media_dir = /home/dustinswan/Music

        [spotify]
        enabled = true
        username =
        password =
        client_id =
        client_secret =
        bitrate = 320

        [scrobbler]
        enabled = true
        username = dustinswan
      '';
    };

    locate.enable = true;

    udisks2.enable = true;

    printing.enable = true;

    upower.enable = true;

    offlineimap = {
      enable = true;
      install = true;
      path = [ pkgs.gnupg ];
    };

    xserver = {
      enable = true;

      videoDrivers = [ "nvidia" ];
      resolutions = [ { x = 2560; y = 1440; } ];

      desktopManager = {
        default = "none";
        xterm.enable = false;
      };

      displayManager = {
        lightdm.enable = true;
        lightdm.background = "/home/dustinswan/Sync/Pictures/Wallpaper/green_squares.png";
        lightdm.autoLogin.user = "dustinswan";
        sessionCommands = ''
          setxkbmap -option ctrl:nocaps -option compose:ralt
          xcape -e 'Control_L=Escape'
          xmodmap -e "keycode 96 = dead_greek dead_greek dead_greek dead_greek"
          compton -b --inactive-opacity 0.90
          sh ~/dotfiles/logitech_linux_mouse.sh
          xsetroot -solid black -cursor_name left_ptr
          nitrogen --restore &
          qsyncthingtray &
          pasystray &
        '';
      };

      windowManager = {
        i3 = {
          enable = true;
          package = pkgs.i3-gaps;
          extraPackages = with pkgs; [
            dmenu
            i3status
            i3lock
          ];
        };

        default = "i3";
      };
    };

    syncthing = {
      enable = true;
      dataDir = "/home/dustinswan";
      user = "dustinswan";
    };

    urxvtd.enable = true;

    emacs = {
      enable = true;
      defaultEditor = true;
    };

    ipfs = {
      enable = true;
    };

    synergy.server = {
      enable = true;
      screenName = "pc";
    };

  };

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      zeroconf.discovery.enable = true;
      tcp = {
        enable = true;
        anonymousClients.allowedIpRanges = ["127.0.0.1"];
      };
    };
    bluetooth.enable = true;
  };

  sound.enable = true;
  sound.mediaKeys.enable = true;

  programs.fish.enable = true;

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts # includes Iosevka
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

  virtualisation.virtualbox.host.enable = true;

  users.users.dustinswan = {
    createHome = true;
    description = "Dustin Swan";
    isNormalUser = true;
    extraGroups = [ "wheel" "sound" "pulse" "audio" "networkmanager" "vboxusers" ];
    uid = 1000;
    shell = pkgs.fish;
  };

  environment.etc."synergy-server.conf" = { text = ''
    section: screens
      pc:
      mac:
    end

    section: aliases
      mac:
        192.168.1.2
    end

    section: links
      pc:
        left = mac
      mac:
        right = pc
    end
  ''; };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?
}
