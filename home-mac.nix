{ pkgs, ... }:

let
  machine = import ./machine.nix;
in
{
  home.homeDirectory = "/Users/dustinswan";

  home.packages = with pkgs; [
    pinentry_mac
    iina
    moonlight-qt
  ];

  home.sessionPath = [ "/opt/homebrew/bin" ];
  home.sessionVariables.BROWSER = "open";

  programs.man.generateCaches = false;

  programs.ghostty.package = pkgs.ghostty-bin;
  programs.ghostty.settings.font-size = 16;

  # Remember SSH key passphrases in the macOS Keychain
  programs.ssh.settings."*".UseKeychain = "yes";

  # Read-only on purpose: edit here, not in the Karabiner GUI
  xdg.configFile."karabiner/karabiner.json".text = builtins.toJSON {
    global.show_in_menu_bar = false;
    profiles = [{
      name = "Default";
      selected = true;
      virtual_hid_keyboard.keyboard_type_v2 = "ansi";
      complex_modifications.rules = [{
        description = "Caps Lock: Escape when tapped, Control when held";
        manipulators = [{
          type = "basic";
          from = { key_code = "caps_lock"; modifiers.optional = [ "any" ]; };
          to = [{ key_code = "left_control"; }];
          to_if_alone = [{ key_code = "escape"; }];
        }];
      }];
    }];
  };

  home.file.gpg-agent = {
    target = ".gnupg/gpg-agent.conf";
    text = ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      default-cache-ttl 34560000
      max-cache-ttl 34560000
    '';
  };

  launchd.agents.mbsync = {
    enable = machine.isPersonal;
    config = {
      ProgramArguments = [ "${pkgs.isync}/bin/mbsync" "-a" ];
      StartInterval = 900;  # every 15 minutes
      StandardOutPath = "/tmp/mbsync.log";
      StandardErrorPath = "/tmp/mbsync.err";
      EnvironmentVariables = {
        PATH = "${pkgs.pass}/bin:${pkgs.gnupg}/bin:/usr/bin:/bin";
      };
    };
  };

  launchd.agents.vdirsyncer = {
    enable = machine.isPersonal;
    config = {
      ProgramArguments = [ "${pkgs.vdirsyncer}/bin/vdirsyncer" "sync" ];
      StartInterval = 900;  # every 15 minutes
      StandardOutPath = "/tmp/vdirsyncer.log";
      StandardErrorPath = "/tmp/vdirsyncer.err";
      EnvironmentVariables = {
        PATH = "${pkgs.pass}/bin:${pkgs.gnupg}/bin:/usr/bin:/bin";
      };
    };
  };

  # https://codeberg.org/adamcstephens/dotfiles/src/commit/e14f35f6e9a9cb9174016948c512c0db364e0dec/apps/fish/init.fish
  programs.fish.shellInit = ''
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
  '';

  imports = [
    ./home-cli.nix
    ./home-gui.nix
    ./home-majorrocket.nix
    ./home-mail.nix
    ./home-sync.nix
  ];
}
