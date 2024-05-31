{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pinentry_mac
    terminal-notifier
  ];

  home.file.gpg-agent = {
    target = ".gnupg/gpg-agent.conf";
    text = ''
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  imports = [ ./home-cli.nix ./home-gui.nix ./home-mail.nix ];
}
