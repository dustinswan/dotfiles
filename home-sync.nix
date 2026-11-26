{ pkgs, machine, lib, ... }:

let
  thisDevice = if pkgs.stdenv.hostPlatform.isDarwin then "Laptop" else "Desktop";

  members = {
    Camera = [ "Desktop" "Laptop" "Phone" ];
    Sync = [ "Desktop" "Laptop" "Phone" ];
    Passwords = [ "Desktop" "Laptop" ];
    Music = [ "Desktop" "Laptop" ];  # phone streams from Navidrome instead (FLAC is too big)
    CG = [ "Desktop" "Laptop" ];  # a backup, not a sync: the laptop sends, the desktop keeps
  };

  isLaptop = thisDevice == "Laptop";

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
        # CG's private data lives only on the laptop: tasks, notes, finances, kept files.
        # one way. the laptop only sends, so nothing done on the desktop can come back
        # and change the live image; the desktop only receives and keeps old versions, so
        # a file deleted or mangled on the laptop is still there. what is left out
        # (build output, .env) is in ~/Code/cg/.stignore on the laptop
        "CG" = {
          id = "cg-backup";
          path = if isLaptop then "~/Code/cg" else "~/Backup/cg";
          devices = peers "CG";
          type = if isLaptop then "sendonly" else "receiveonly";
        } // (if isLaptop then {
          # cg rewrites its cache and state every few seconds while in use; gather
          # changes for five minutes instead of sending each one
          fsWatcherDelayS = 300;
        } else {
          # a year of history, thinned as it ages: every version for an hour, hourly
          # for a day, daily for a month, weekly after
          versioning = {
            type = "staggered";
            params.maxAge = "31536000";
            cleanupIntervalS = 3600;
          };
        });
      };
    };
  };
}
