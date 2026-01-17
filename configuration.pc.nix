# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main.capslock = "overload(control, esc)";

        # Emacs bindings (Dvorak physical positions)
        # Use Alt-Backspace for delete-word (works everywhere natively)
        # control = {
        #   # a = "home";            # C-a → Home
        #   d = "end";             # C-e → End (dvorak 'e' = qwerty 'd')
        #   r = "up";              # C-p → Up (dvorak 'p' = qwerty 'r')
        #   l = "down";            # C-n → Down (dvorak 'n' = qwerty 'l')
        #   j = "backspace";       # C-h → Backspace (dvorak 'h' = qwerty 'j')
        #   m = "enter";           # C-m → Enter
        # };

        # # macOS-style Super/Cmd shortcuts (Dvorak physical positions)
        # meta = {
        #   # a = "C-a";             # Cmd+a → select all
        #   i = "C-i";             # Cmd+c → copy (dvorak 'c' = qwerty 'i')
        #   k = "C-k";             # Cmd+t → new tab (dvorak 't' = qwerty 'k')
        #   l = "C-l";             # Cmd+n → new window (dvorak 'n' = qwerty 'l')
        #   comma = "C-comma";     # Cmd+w → close tab (dvorak 'w' = qwerty ',')
        #   period = "C-period";   # Cmd+v → paste (dvorak 'v' = qwerty '.')
        #   semicolon = "C-semicolon"; # Cmd+s → save (dvorak 's' = qwerty ';')
        #   slash = "C-slash";     # Cmd+z → undo (dvorak 'z' = qwerty '/')
        #   x = "C-x";             # Cmd+q → quit (dvorak 'q' = qwerty 'x')
        #   b = "C-b";             # Cmd+x → cut (dvorak 'x' = qwerty 'b')
        # };
      };
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  services.udev.packages = with pkgs; [ sunshine ];
  security.polkit.enable = true;

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dustinswan = {
    isNormalUser = true;
    description = "Dustin Swan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    # packages = with pkgs; [  ];
  };

  programs.fish.enable = true;
  programs.steam.enable = true;
  # programs.xwayland.enable = true;
  # programs.hyprland.enable = true;
  # programs.niri.enable = true;
  # programs.dms-shell.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    24800 # Deskflow
    24801 # Deskflow
    53317 # LocalSend
  ];

  networking.firewall.allowedUDPPorts = [
    24800 # Deskflow
    24801 # Deskflow
    53317 # LocalSend
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
