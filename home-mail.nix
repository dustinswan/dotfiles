{ pkgs, ... }:

{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.himalaya.enable = true;
  programs.vdirsyncer.enable = true;
  programs.khard.enable = true;
  programs.notmuch = {
    enable = true;
    new = {
      tags = [ "new" ];
    };
    hooks = {
      preNew = "mbsync -a";
    };
  };

  accounts.email.accounts.FastMail.notmuch.enable = true;
  programs.aerc = {
    enable = true;
    extraConfig = {
      general.unsafe-accounts-conf = true;
      ui = {
        mouse-enabled = true;
        threading-enabled = true;
      };
      compose = {
        address-book-cmd = "khard email --parsable '%s'";
      };
      filters = {
        "text/html" = "${pkgs.w3m}/bin/w3m -T text/html -cols $(tput cols) -dump -o display_image=false -o display_link_number=true";
      };
    };
  };

  accounts.email = {
    maildirBasePath = "Mail";
    certificatesFile = "${builtins.getEnv "HOME"}/.nix-profile/etc/ssl/certs/ca-bundle.crt";

    accounts = {
      FastMail = {
        flavor = "fastmail.com";
        address = "dustin@dustinswan.com";
        aliases = [ "dustinswan@gmail.com" ];
        realName = "Dustin Swan";
        primary = true;
        folders = {
          inbox = "INBOX";
          drafts = "Drafts";
          sent = "Sent";
          trash = "Trash";
        };
        userName = "dustinswan@fastmail.com";
        gpg = {
          signByDefault = true;
          key = "AD11750151C10881970BD943AB49BD6B2B3A6377";
        };
        passwordCommand = "pass show email/fastmail";
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "maildir";
        };
        imapnotify = {
          enable = true;
          boxes = [ "INBOX" ];
          onNotify = "${pkgs.isync}/bin/mbsync FastMail:INBOX";
          onNotifyPost = let
            notifyCmd = if pkgs.stdenv.isDarwin
              then "${pkgs.terminal-notifier}/bin/terminal-notifier -title 'New Mail' -message 'FastMail INBOX' -sound default"
              else "${pkgs.libnotify}/bin/notify-send 'New Mail' 'FastMail INBOX'";
          in notifyCmd;
        };
        msmtp.enable = true;
        aerc.enable = true;
        himalaya = {
          enable = true;
          settings = {
            # backend = "imap";
            # maildir.root-dir = "/Users/dustinswan/Mail/FastMail";
            # message.send.backend = "smtp";
            # sent-folder = "Sent";
            # draft-folder = "Drafts";
          };
        };
        signature = {
          text = ''Dustin Swan | dustinswan.com'';
          showSignature = "append";
        };
      };
    };
  };

  accounts.calendar = {
    basePath = "Calendars";
    accounts = {
      FastMail = {
        khal = {
          enable = true;
          # addresses = [ "dustin@dustinswan.com" ];
          type = "discover";
        };
        primary = true;
        remote = {
          passwordCommand = ["pass" "show" "email/fastmail"];
          type = "caldav";
          url = "https://caldav.fastmail.com/dav/";
          userName = "dustinswan@fastmail.com";
        };
        vdirsyncer = {
          enable = true;
          collections = ["from a" "from b"];
        };
      };
    };
  };

  accounts.contact = {
    basePath = "Contacts";
    accounts = {
      FastMail = {
        khard.enable = true;
        remote = {
          passwordCommand = ["pass" "show" "email/fastmail"];
          type = "carddav";
          url = "https://carddav.fastmail.com/dav/";
          userName = "dustinswan@fastmail.com";
        };
        vdirsyncer = {
          enable = true;
          collections = ["from a" "from b"];
        };
      };
    };
  };
}
