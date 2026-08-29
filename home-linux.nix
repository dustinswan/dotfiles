{pkgs, lib, ... }:

let
  secrets = import ./secrets.nix;
in

{
  home.homeDirectory = "/home/dustinswan";

  home.packages = with pkgs; [
    # retroarch gimp blender
    brave
    nerd-fonts.iosevka
    deskflow
    # CD ripping -> /srv/music (needs a USB optical drive; this box has none)
    abcde        # rips + encodes + tags in one command
    picard       # MusicBrainz tagger, for fixing what abcde gets wrong
    flac
    cdparanoia   # error-correcting CD reader used by abcde
    # sunshine # provided by services.sunshine in configuration.pc.nix (the module wraps the binary with CAP_SYS_ADMIN for KMS capture); a second copy here shipped a conflicting user unit
    # steam # added as a system package, so it actually works
    # wl-clipboard  # For Wayland clipboard (wl-copy, wl-paste)
  ];

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = caffeine; }
      { package = vitals; }
      { package = appindicator; }
      { package = syncthing-indicator; }
      { package = blur-my-shell; }
      { package = media-controls; }
    ];
  };

  dconf.settings = {
    # Custom keybinding for Vicinae
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Vicinae";
      command = "vicinae toggle";
      binding = "<Super>space";
    };

    # Extension settings
    "org/gnome/shell/extensions/vitals" = {
      show-gpu = true;
    };
    "org/gnome/shell/extensions/caffeine" = {
      show-indicator = "always";
    };
    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };
  };

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };

  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "Desktop" = { id = secrets.syncthing.desktop; };
        "Laptop" = { id = secrets.syncthing.laptop; };
        "Phone" = { id = secrets.syncthing.phone; };
      };
      folders = {
        "Camera" = {
          id = "sm-n950u-photos";
          path = "~/Camera";
          devices = [ "Laptop" "Phone" ];
        };
        "Sync" = {
          path = "~/Sync";
          devices = [ "Laptop" "Phone" ];
        };
        "Passwords" = {
          path = "~/.password-store";
          devices = [ "Laptop" ];
        };
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    defaultCacheTtlSsh = 34560000;
    maxCacheTtlSsh = 34560000;
    pinentry.package = pkgs.pinentry-all;
  };

  services.mbsync = {
    enable = true;
    frequency = "*:0/15";  # every 15 minutes
  };

  services.vdirsyncer = {
    enable = true;
    frequency = "*:0/15";  # every 15 minutes
  };

  # Niri config - imported from separate file
  # xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   settings = {
  #     "$mod" = "ALT";
  #     input = {
  #       kb_layout = "us";
  #       kb_variant = "dvorak";
  #     };
  #     # general = {
  #     #   gaps_in = 0;
  #     #   gaps_out = 0;
  #     #   border_size = 2;
  #     #   "col.active_border" = "rgba(89b4faaa)"; # Example color
  #     #   "col.inactive_border" = "rgba(303030aa)";
  #     # };
  #     # decoration = {
  #     #   shadow_offset = "0 5";
  #     #   "col.shadow" = "rgba(00000099)";
  #     # };
  #     # bindm = [ # Mouse bindings
  #     #   "$mod, mouse:272, movewindow"
  #     #   "$mod, mouse:273, resizewindow"
  #     # ];
  #     bind = [ # Keyboard bindings
  #       # "$mod, Q, killactive,"
  #       # "$mod, M, exit," # Exit Hyprland
  #       # "$mod, E, exec, firefox" # Open Firefox
  #       "$mod, Enter, exec, ghostty"
  #     ];
  #     exec-once = [ # Run once on startup
  #       "vicinae server &"
  #     ];
  #   };
  # };

  imports = [ ./home-cli.nix ./home-gui.nix ./home-mail.nix ];
}
