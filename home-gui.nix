{ pkgs, ... }:

{
  # fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    localsend
    # deskflow
  ];

  programs.sioyek.enable = true;

  programs.halloy = {
    enable = true;
    settings = {
      servers.liberachat = {
        nickname = "sw4n";
        server = "irc.libera.chat";
        nick_password_file = "/Users/dustinswan/.liberachat-nickserv-password";
        channels = ["#halloy" "#haskell" "#nixos"];
      };
    };
  };

  programs.ghostty = {
    enable = true;
    installBatSyntax = false;

    settings = {
      font-family = "Iosevka NFM";
      font-size = 12;
      font-thicken = true;
      theme = "dark:TokyoNight Storm,light:TokyoNight Day";
      background-opacity = 0.95;
      background-blur-radius = 15;
      window-padding-x = 12;
      window-padding-y = 8;
      window-padding-balance = true;
      macos-titlebar-style = "tabs";
      window-theme = "auto";
      macos-option-as-alt = "left";
      copy-on-select = "clipboard";
    };
  };

  programs.zed-editor = {
    enable = true;
    userSettings = {
      vim_mode = true;
      theme = {
        mode = "system";
        light = "Tokyo Night Light";
        dark = "Tokyo Night Storm";
      };
      buffer_font_size = 16;
      buffer_font_family = "Iosevka Nerd Font Mono";
      vim = {
        enable_vim_sneak = true;
        use_smartcase_find = true;
      };
      format_on_save = "off";
    };
  };
}
