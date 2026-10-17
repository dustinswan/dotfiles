{ pkgs, machine, lib, ... }:

let
  thisDevice = if pkgs.stdenv.hostPlatform.isDarwin then "Laptop" else "Desktop";

  members = {
    Camera = [ "Desktop" "Laptop" "Phone" ];
    Sync = [ "Desktop" "Laptop" "Phone" ];
    Passwords = [ "Desktop" "Laptop" ];
    Music = [ "Desktop" "Laptop" ];  # phone streams from Navidrome instead (FLAC is too big)
  };

  peers = folder: lib.filter (d: d != thisDevice) members.${folder};
in

lib.mkIf machine.isPersonal {
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "Desktop" = { id = "UKJHL7N-FXOF2OF-7EX3CGA-IQWJUPP-2FRDIXL-66DGW6R-7VIHQKB-6AKBLAT"; };
        "Laptop" = { id = "KCZEG7C-HN7QWZ2-B5TNAHR-SREKOQE-NO4AJK3-VR45ZHX-5EGO5LV-QU5PQAR"; };
        "Phone" = { id = "Q6BFRXT-HJZHFGU-LUADMNP-OV4E54M-4BAVUVU-LQKWDAO-DGEIDIN-5FG5EQ4"; };
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
        "Music" = {
          path = if pkgs.stdenv.hostPlatform.isDarwin then "~/Music/Library" else "/srv/music";
          devices = peers "Music";
        };
      };
    };
  };
}
