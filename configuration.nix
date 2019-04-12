# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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
      fcitx.engines = with pkgs.fcitx-engines; [ anthy mozc libpinyin ];
    };
  };

  time.timeZone = "America/New_York";

  # environment.systemPackages = with pkgs; [
  # ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;

  services = {
    zerotierone = {
      enable = true;
      joinNetworks = [ "1d719394045bb17d" ];
    };

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    transmission = {
      enable = true;
    };

    locate.enable = true;

    udisks2.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint pkgs.brlaser ];
    };

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
        # sessionCommands = ''
        #   setxkbmap -option ctrl:nocaps -option compose:ralt
        #   xcape -e 'Control_L=Escape'
        #   xmodmap -e "keycode 96 = dead_greek dead_greek dead_greek dead_greek"
        #   compton -b --inactive-opacity 0.90
        #   sh ~/dotfiles/logitech_linux_mouse.sh
        #   xsetroot -solid black -cursor_name left_ptr
        #   nitrogen --restore &
        #   qsyncthingtray &
        #   pasystray &
        # '';
      };

      windowManager = {
        i3 = {
          enable = true;
          package = pkgs.i3-gaps;
        };

        default = "i3";
      };
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

  virtualisation.docker.enable = true;

  users.users.dustinswan = {
    createHome = true;
    description = "Dustin Swan";
    isNormalUser = true;
    extraGroups = [ "wheel" "sound" "pulse" "audio" "networkmanager" "vboxusers" "docker" ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  environment.etc."synergy-server.conf" = { text = ''
    section: screens
      pc:
      mac:
    end

    section: links
      mac:
        left = pc
      pc:
        right = mac
    end

    section: options
      keystroke(super+tilde) = switchInDirection(left)
      keystroke(super+backspace) = switchInDirection(right)
      mousebutton(6) = keystroke(WWWBack)
      mousebutton(7) = keystroke(WWWForward)
    end
  ''; };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?
}
