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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sw4n"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
    # inputMethod.enabled = "ibus";
    inputMethod.enabled = "fcitx";
    # inputMethod.ibus.engines = with pkgs.ibus-engines; [ anthy mozc ];
    inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ anthy mozc ];
  };

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget vim clipit compton emacs feh firefox fzf git gparted gucharmap htop keepassx2 keychain ncmpcpp neovim noto-fonts-cjk pandoc polybar python qutebrowser rofi rxvt_unicode silver-searcher syncthing tmux tree unzip wirelesstools xcape xclip spotify anki mopidy mopidy-soundcloud mopidy-spotify mopidy-youtube pavucontrol ranger
  ];

  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.udisks2.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "dvorak";
  services.xserver.videoDriver = "nvidia";
  services.xserver.resolutions = [ { x = 2560; y = 1440; } ];

  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.palmDetect = true;
  services.xserver.synaptics.palmMinWidth = 5;
  services.xserver.synaptics.palmMinZ = 20;
  services.xserver.synaptics.twoFingerScroll = true;
  services.xserver.synaptics.accelFactor = "0.005";
  services.xserver.synaptics.buttonsMap = [ 1 3 2 ];

  services.upower.enable = true;

  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.slim.defaultUser = "dustinswan";

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.default = "xmonad";

  services.syncthing = {
    enable = true;
    # useInotify = true;
    user = "dustinswan";
    dataDir = "/home/dustinswan/";
  };

  services.urxvtd.enable = true;

  services.emacs.enable = true;
  services.emacs.defaultEditor = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.zeroconf.discovery.enable = true;
  hardware.bluetooth.enable = true;
  sound.mediaKeys.enable = true;
  
  programs.fish.enable = true;

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts # includes Iosevka
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      siji
    ];
  };

  users.extraUsers.dustinswan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sound" "pulse" "audio" "networkmanager" ];
    uid = 1000;
    shell = pkgs.fish;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
