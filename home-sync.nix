{ pkgs, lib, ... }:

let
  secrets = import ./secrets.nix;

  thisDevice = if pkgs.stdenv.hostPlatform.isDarwin then "Laptop" else "Desktop";

  members = {
    Camera = [ "Desktop" "Laptop" "Phone" ];
    Sync = [ "Desktop" "Laptop" "Phone" ];
    Passwords = [ "Desktop" "Laptop" ];
  };

  peers = folder: lib.filter (d: d != thisDevice) members.${folder};
in

lib.mkIf (secrets ? syncthing) {
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
