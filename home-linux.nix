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
    # CD ripping -> /srv/music (needs a USB optical drive; this box has none)
    abcde        # rips + encodes + tags in one command
    picard       # MusicBrainz tagger, for fixing what abcde gets wrong
    flac
    cdparanoia   # error-correcting CD reader used by abcde
    # sunshine # provided by services.sunshine in configuration.pc.nix (the module wraps the binary with CAP_SYS_ADMIN for KMS capture); a second copy here shipped a conflicting user unit
    # steam # added as a system package, so it actually works
    wl-clipboard  # wl-copy/wl-paste; Claude Code needs wl-paste to paste images
  ];

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = caffeine; }
      { package = vitals; }
      { package = appindicator; }
      { package = syncthing-indicator; }
      { package = blur-my-shell; }
      { package = media-controller; }  # media-controller@naimur; the old media-controls is dead on GNOME 50
      { package = paperwm; }
    ];
  };

  dconf.settings = {
    # Custom keybinding for Vicinae
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ "<Super><Alt>l" ];  # lock moved off Super+l for PaperWM
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

    # PaperWM: vim-style hjkl (keysyms, so dvorak letters) plus the stock arrow/comma binds
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      switch-left = [ "<Super>h" "<Super>Left" ];
      switch-down = [ "<Super>j" "<Super>Down" ];
      switch-up = [ "<Super>k" "<Super>Up" ];
      switch-right = [ "<Super>l" "<Super>Right" ];
      move-left = [ "<Super><Shift>h" "<Super><Ctrl>comma" "<Super><Shift>comma" "<Super><Ctrl>Left" ];
      move-down = [ "<Super><Shift>j" "<Super><Ctrl>Down" ];
      move-up = [ "<Super><Shift>k" "<Super><Ctrl>Up" ];
      move-right = [ "<Super><Shift>l" "<Super><Ctrl>period" "<Super><Shift>period" "<Super><Ctrl>Right" ];
    };
    # Mac-style screenshots (the K3's screenshot key sends Cmd+Shift+4); both copy to clipboard
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "Print" "<Super><Shift>4" ];
      screenshot = [ "<Shift>Print" "<Super><Shift>3" ];
    };
    # Free up Super+h (minimize) for PaperWM
    "org/gnome/desktop/wm/keybindings" = {
      minimize = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
    };
  };

  # right Shift+F12
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      no_display = true;
    };
  };

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    pinentry.package = pkgs.pinentry-all;
  };

  services.mbsync = {
    enable = secrets ? mail;  # config comes from home-mail.nix, which is gated the same way
    frequency = "*:0/15";  # every 15 minutes
  };

  services.vdirsyncer = {
    enable = secrets ? mail;
    # Offset from mbsync: identical schedules fired both jobs in the same second,
    # and their two "pass show" calls raced for the GnuPG keyboxd lock - one won,
    # the other timed out with "keydb_search failed" and the unit failed.
    frequency = "*:7/15";  # every 15 minutes, 7 past
  };

  imports = [
    ./home-cli.nix
    ./home-gui.nix
    ./home-majorrocket.nix
    ./home-mail.nix
    ./home-sync.nix
  ];
}
