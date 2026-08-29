{ pkgs, lib, ... }:

let
  secrets = import ./secrets.nix;

  # Which Syncthing device this machine is. Only two machines share this
  # config: the MacBook ("Laptop") and the NixOS desktop ("Desktop").
  thisDevice = if pkgs.stdenv.hostPlatform.isDarwin then "Laptop" else "Desktop";

  # Full membership of each folder, including this machine. Syncthing always
  # adds the local device to its own folders, so what gets declared below is
  # the membership minus whichever device we are.
  members = {
    Camera = [ "Desktop" "Laptop" "Phone" ];
    Sync = [ "Desktop" "Laptop" "Phone" ];
    Passwords = [ "Desktop" "Laptop" ];
  };

  peers = folder: lib.filter (d: d != thisDevice) members.${folder};
in

{
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "Desktop" = { id = secrets.syncthing.desktop; };
        "Laptop" = { id = secrets.syncthing.laptop; };
        "Phone" = { id = secrets.syncthing.phone; };
      };
      folders = {
        "Camera" = {
          id = "sm-n950u-photos";
          path = "~/Camera";
          devices = peers "Camera";
        };
        "Sync" = {
          path = "~/Sync";
          devices = peers "Sync";
        };
        "Passwords" = {
          path = "~/.password-store";
          devices = peers "Passwords";
        };
      };
    };
  };
}
