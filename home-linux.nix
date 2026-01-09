{pkgs, lib, ... }:

{
  home.homeDirectory = "/home/dustinswan";

  home.packages = with pkgs; [
    # retroarch gimp blender
    brave
    # ghostty
    bitwarden-desktop
    nerd-fonts.iosevka
    high-tide tidal-hifi
    deskflow
    sunshine
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
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    maxCacheTtlSsh = 86400;
    pinentry.package = pkgs.pinentry-all;
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
