{ pkgs, ... }:

{
  home.homeDirectory = "/Users/dustinswan";

  home.packages = with pkgs; [
    pinentry_mac
    terminal-notifier
  ];

  programs.ghostty.package = pkgs.ghostty-bin;
  programs.ghostty.settings.font-size = 16;

  home.file.gpg-agent = {
    target = ".gnupg/gpg-agent.conf";
    text = ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  # https://codeberg.org/adamcstephens/dotfiles/src/commit/e14f35f6e9a9cb9174016948c512c0db364e0dec/apps/fish/init.fish
  programs.fish.shellInit = ''
      fenv source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      source /nix/var/nix/profiles/default/etc/profile.d/nix.fish
  '';

  imports = [ ./home-cli.nix ./home-gui.nix ./home-mail.nix ];
}
