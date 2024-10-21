{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pinentry_mac
    terminal-notifier
  ];

  home.file.gpg-agent = {
    target = ".gnupg/gpg-agent.conf";
    text = ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  imports = [ ./home-cli.nix ./home-gui.nix ./home-mail.nix ];
}
