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
}
