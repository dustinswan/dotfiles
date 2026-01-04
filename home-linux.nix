{pkgs, lib, ... }:

{
  home.homeDirectory = "/home/dustinswan";

  home.packages = with pkgs; [
    # retroarch gimp blender
    brave
    ghostty
    bitwarden-desktop
    nerd-fonts.iosevka
    high-tide tidal-hifi
    deskflow
  ];

  # home.keyboard.options = [ "ctrl:nocaps" "compose:ralt" ];

  programs.vicinae = {
    enable = true;
  };

  services.syncthing = {
    enable = true;
  };

  imports = [ ./home-cli.nix ./home-gui.nix ./home-mail.nix ];
}
