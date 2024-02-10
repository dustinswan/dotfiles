{ pkgs, ... }:

{
  # home.packages = with pkgs; [ iosevka-bin ];
  fonts.fontconfig.enable = true;

  # programs.rio = {
  #   enable = true;
  #   settings = {
  #     fonts = {
  #       family = "Iosevka Nerd Font";
  #       size = 20;
  #     };

  #     window = {
  #       foreground-opacity = 1.0;
  #       background-opacity = 0.9;
  #       blur = true;
  #     };

  #     # disable-ctlseqs-alt = true;
  #     option-as-alt = "left";
  #     padding-x = 10;

  #     adaptive-theme = {
  #       dark = "catppuccin-mocha";
  #       light = "catppuccin-latte";
  #     };

  #     navigation = {
  #       # mode = "Plain";
  #       mode = "Breadcrumb";
  #     };

  #     bindings = {
  #       keys = [
  #         { key = "w"; "with" = "control"; bytes = [27 91 53 126]; }
  #       ];
  #     };
  #   };
  # };

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
  };
}
