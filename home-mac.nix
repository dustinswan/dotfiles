{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ pinentry_mac terminal-notifier syncthing ];

  # home.file.gpg-agent = {
  #   target = ".gnupg/gpg-agent.conf";
  #   text = ''
  #     default-cache-ttl 86400
  #     max-cache-ttl 86400
  #   '';
  # };

  # home.file.gitignore = {
  #   target = ".gitignore";
  #   text = ''Library'';
  # };

  imports = [ ./home-cli.nix ./home-gui.nix ./home-mail.nix ];
}
