{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ pinentry_mac ];

  home.file.gpg-agent = {
    target = ".gnupg/gpg-agent.conf";
    text = ''
      pinentry-program ${builtins.getEnv "HOME"}/.nix-profile/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  imports = [ ./home-common.nix ];
}
