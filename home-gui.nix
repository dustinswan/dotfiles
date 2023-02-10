{ pkgs, ... }:

{
  # home.packages = with pkgs; [ iosevka-bin ];
  fonts.fontconfig.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "buttonless";
        padding = {
          x = 12;
          y = 12;
        };
        dimentions = {
          columns = 0;
          lines = 0;
        };
        opacity = 0.95;
      };
      font = {
        normal.family = "Iosevka Nerd Font";
        bold.family = "Iosevka Nerd Font";
        italic.family = "Iosevka Nerd Font";
        size = 16.0;
      };
      key_bindings = [
        { key = "F"; mods = "Alt"; chars = "\\x1Bf"; }
        { key = "B"; mods = "Alt"; chars = "\\x1Bb"; }
      ];
    };
  };
}
