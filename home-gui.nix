{ pkgs, ... }:

# Ghostty not building on my mac at the moment
let
  ghostty-mock = pkgs.writeShellScriptBin "gostty-mock" ''
    true
    '';
in {
  fonts.fontconfig.enable = true;

  programs.ghostty = {
    enable = true;
    installBatSyntax = false;
    package = ghostty-mock;

    settings = {
      font-family = "Iosevka NFM";
      font-size = 16;
      font-thicken = true;
      # theme = "dark:catppuccin-mocha,light:catppuccin-latte";
      theme = "catppuccin-mocha";
      background-opacity = 0.95;
      background-blur-radius = 15;
      window-padding-x = 12;
      window-padding-y = 8;
      window-padding-balance = true;
      macos-titlebar-style = "tabs";
      macos-option-as-alt = "left";
      copy-on-select = "clipboard";
      # keybind = "global:cmd+grave_accent=toggle_quick_terminal";
    };
  };

  programs.zed-editor = {
    enable = true;
    userSettings = {
      vim_mode = true;
      theme = {
        mode = "system";
        # light = "Catppuccin Latte";
        # dark = "Catppuccin Frappé";
      };
      buffer_font_size = 16;
      buffer_font_family = "Iosevka Nerd Font Mono";
      # "ui_font_family": "Iosevka Nerd Font";
      vim = {
        enable_vim_sneak = true;
        use_smartcase_find = true;
      };
    };
  };

  home.file.halloy = {
    target = ".config/halloy/config.toml";
    text = ''
theme = "catppuccin-mocha"

[servers.liberachat]
nickname = "sw4n"
server = "irc.libera.chat"
nick_password_file = "/Users/dustinswan/.liberachat-nickserv-password"
channels = ["#halloy", "#haskell", "#nixos"]

[font]
size = 16
    '';
  };
}
