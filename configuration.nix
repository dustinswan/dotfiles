# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "swan-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    fish
    i3
    i3status
    dmenu
    wget
  ];

  environment.shells = [ "/run/current-system/sw/bin/zsh" ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  time.timeZone = "America/Chicago";
  services.ntp.enable = false;
  services.chrony.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "dvorak";
  # services.xserver.xkbOptions = "eurosign:e";

  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;

  services.xserver.displayManager.slim.enable = true;

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.default = "i3";

  services.xserver.resolutions = [ { x = 1440; y = 900; } ];

  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  users.defaultUserShell = "/var/run/current-system/sw/bin/zsh";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.dustinswan = {
    name = "dustinswan";
    group = "users";
    extraGroups = [ "wheel" ];
    createHome = true;
    home = "/home/dustinswan";
    useDefaultShell = true;
  };

}
