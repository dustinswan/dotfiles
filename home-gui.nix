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
        opacity = 0.95;
      };
      font = {
        normal.family = "Iosevka NF";
        bold.family = "Iosevka NF";
        italic.family = "Iosevka NF";
        size = 16.0;
      };
    };
    catppuccin.enable = true;
  };
}
