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
    sunshine
  ];

  # home.keyboard.options = [ "ctrl:nocaps" "compose:ralt" ];

  programs.vicinae = {
    enable = true;
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

  imports = [ ./home-cli.nix ./home-gui.nix ./home-mail.nix ];
}
