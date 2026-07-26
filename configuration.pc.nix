# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # /etc/nixos/configuration.nix is a symlink to this file; nix resolves
      # relative imports from the real path, so this stays inside the repo.
      ./hardware-configuration.pc.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Machines are named for stars in Cygnus, the Swan. Deneb is its brightest.
  # Names describe the box, never its role - roles move between machines.
  networking.hostName = "deneb";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  services.tailscale = {
    enable = true;
    # "server" turns on IP forwarding, required to act as an exit node.
    # Still has to be advertised (--advertise-exit-node) and approved in the admin console.
    useRoutingFeatures = "server";
  };
  # Everything arriving over the tailnet is trusted; other interfaces stay closed
  # unless a port is explicitly opened below. This is what keeps ssh/navidrome
  # reachable from the tailnet only.
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # Wake-on-LAN. eno1 has no cable today, so this does nothing until one is
  # plugged in - at which point it's already configured. Also needs enabling in BIOS.
  networking.interfaces.eno1.wakeOnLan.enable = true;

  # Always-on box: never sleep.
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

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
  # Upstream's unit ships "sleep 5: avoid starting before the desktop is fully
  # initialized" but the NixOS module drops it; without it the login-time start
  # hits "RTSP port 48010 already in use" and wedges with no listeners.
  systemd.user.services.sunshine.serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
  services.udev.packages = with pkgs; [ sunshine ];
  # DualSense (ds5) emulation needs /dev/uhid, which is root-only by default
  services.udev.extraRules = ''
    KERNEL=="uhid", GROUP="input", MODE="0660"
  '';
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
    # "input"/"uinput" let Sunshine create virtual gamepads (fixes "Gamepad ds5 disabled due to Permission denied")
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" ];
    # Password auth is off, so ssh only works for keys listed here.
    # Add each new machine's public key as it joins the tailnet.
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZABklyeo2an+O94Ra0MLoYGI3LDHnsA+P+CTNye4h3dJHBJXCUV++VcDtBiA5CEDXm4JKvSQPexmN9Gx8lwLGSSR/np3eLh39UjmPvmpahAPqb9HOBoKh4USNX0EmnJAVpOMDQr9Vt7UA49NpaNUXBIfeDwvoG5XAy/CfyyTskCSzZSBORCYNxdk/jWy/fJq85zQbQy35l6KQYsLt3GZJms5WIO0X/4hUiqHOf5FOFXlE9OXSFM31I+faR1lzN3rGPr+tG68mg16Uck4nUKZwBRAHCpoO2aHlyBR7I2EV2ceU6TpAuLnW0RxqPuLsCCXcr96YCydipLR5WERN9cW/05qY7JB12SHZbK4hUTqijGfE8w0iGP4YQvL+H6bfQBJY33+tXF1XvnyqNoaJle3039/W9Sjdzna4DLPh9Ttp/cmJsFLe+qhZTDrlQHnE4u9283R2mLBFRx3tasNYyqfjVgvoR1QFiPQCC6QKAqG4Z5lqz8evslKxfP8bLJPGpVX+z5qjrfVg8D7io1cPyk5HeOgROyBWwmdQNdYqnA/ueFXJGwaXbsDZsrw92rh6lAYp6hWiHvcaShKzKNDfI4N8IS/pLVw/ABnToYLle54t0piWRvZIog5eMVNXUlnOD2Y/LHYB3lBCg5mRfC30DmpONys7f15/48hdsGx77bgV4w== dustin@dustinswan.com"
    ];
    shell = pkgs.fish;
    # packages = with pkgs; [  ];
  };

  programs.fish.enable = true;
  programs.steam.enable = true;
  # Run non-Nix dynamically-linked binaries (e.g. Claude Code's native installer)
  programs.nix-ld.enable = true;
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

  # SSH, reachable over the tailnet only: openFirewall = false leaves port 22
  # closed on every interface, and trustedInterfaces lets it through on tailscale0.
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Music server. Same story as ssh: bound to all interfaces, but only the
  # tailnet can actually reach it. Never expose 4533 to the LAN or internet.
  services.navidrome = {
    enable = true;
    openFirewall = false;
    settings = {
      MusicFolder = "/srv/music";
      Address = "0.0.0.0";
      Port = 4533;
    };
  };
  # Owned by me for ripping, readable by the navidrome service user.
  systemd.tmpfiles.rules = [
    "d /srv/music 0775 dustinswan navidrome -"
  ];

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
