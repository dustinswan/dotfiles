{ pkgs, machine, lib, ... }:

let
  userName = "dustinswan@fastmail.com";  # Fastmail login; the password comes from pass
in

lib.mkIf machine.isPersonal {
  programs.mbsync.enable = true;
  programs.vdirsyncer.enable = true;

  accounts.email = {
    maildirBasePath = "Mail";
    certificatesFile = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    accounts.FastMail = {
      flavor = "fastmail.com";
      address = "dustin@dustinswan.com";
      realName = "Dustin Swan";
      primary = true;
      folders.inbox = "INBOX";
      inherit userName;
      passwordCommand = "pass show email/fastmail";
      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "maildir";
      };
    };
  };

  accounts.calendar = {
    basePath = "Calendars";
    accounts.FastMail = {
      primary = true;
      remote = {
        passwordCommand = [ "pass" "show" "email/fastmail" ];
        type = "caldav";
        url = "https://caldav.fastmail.com/dav/";
        inherit userName;
      };
      vdirsyncer = {
        enable = true;
        collections = [ "from a" "from b" ];
      };
    };
  };

  accounts.contact = {
    basePath = "Contacts";
    accounts.FastMail = {
      remote = {
        passwordCommand = [ "pass" "show" "email/fastmail" ];
        type = "carddav";
        url = "https://carddav.fastmail.com/dav/";
        inherit userName;
      };
      vdirsyncer = {
        enable = true;
        collections = [ "from a" "from b" ];
      };
    };
  };
}
