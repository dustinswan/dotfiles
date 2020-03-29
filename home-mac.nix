{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ pinentry_mac terminal-notifier ];

  home.file.gpg-agent = {
    target = ".gnupg/gpg-agent.conf";
    text = ''
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  # pinentry-program ${builtins.getEnv "HOME"}/.nix-profile/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
  programs.zsh.initExtra = "source ~/.nix-profile/etc/profile.d/nix.sh";
  # programs.fish.interactiveShellInit = "source ~/.nix-profile/etc/profile.d/nix.sh";

  imports = [ ./home-common.nix ./home-mail.nix ];
}
