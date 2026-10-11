{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    localsend
    deskflow # share keyboard/mouse; needed on both machines
  ];

  programs.halloy = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      font = {
        size = 16;
        family = "Iosevka NFM";
      };
      servers.liberachat = {
        nickname = "sw4n";
        server = "irc.libera.chat";
        nick_password_file = "${config.home.homeDirectory}/.liberachat-nickserv-password";
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
      theme = "dark:Catppuccin Mocha,light:Catppuccin Latte";
      background-opacity = 0.95;
      background-blur-radius = 15;
      window-padding-x = 12;
      window-padding-y = 8;
      window-padding-balance = true;
      window-theme = "auto";
      macos-option-as-alt = "left";
      copy-on-select = "clipboard";
      bell-features = "attention,title,border";
      shell-integration-features = "cursor,no-sudo,title,ssh-env,ssh-terminfo,path";
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = [ "catppuccin" ];
    userSettings = {
      vim_mode = true;
      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
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
