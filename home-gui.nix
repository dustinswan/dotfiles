{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nerd-fonts.iosevka ];

  programs.halloy = {
    enable = true;
    settings = {
      font = {
        size = 16;
        family = "Iosevka Nerd Font Mono";
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
      font-family = "Iosevka Nerd Font Mono";
      font-size = 12;
      font-thicken = true;
      theme = "dark:Apple System Colors,light:Apple System Colors Light";
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
    userSettings = {
      vim_mode = true;
      buffer_font_size = 16;
      buffer_font_family = "Iosevka Nerd Font Mono";
      vim = {
        enable_vim_sneak = true;
        use_smartcase_find = true;
      };
      format_on_save = "off";
      languages.Nix.language_servers = [ "nixd" "!nil" ];
    };
  };
}
