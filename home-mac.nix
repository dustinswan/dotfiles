{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ pinentry_mac terminal-notifier syncthing ];

  home.file.gpg-agent = {
    target = ".gnupg/gpg-agent.conf";
    text = ''
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  programs.zsh.initExtra = "source ~/.nix-profile/etc/profile.d/nix.sh";
  # programs.fish.interactiveShellInit = "source ~/.nix-profile/etc/profile.d/nix.sh";

  imports = [ ./home-cli.nix ./home-gui.nix ./home-mail.nix ];
}
