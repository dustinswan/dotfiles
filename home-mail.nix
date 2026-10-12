{ pkgs, lib, ... }:

let
  machine = import ./machine.nix;

  mail = {
    address = "dustin@dustinswan.com";
    aliases = [ "dustinswan@gmail.com" ];
    realName = "Dustin Swan";
    userName = "dustinswan@fastmail.com";  # Fastmail login; the password comes from pass
  };

  # Cross-platform opener command
  openCmd = if pkgs.stdenv.hostPlatform.isDarwin then "open" else "${pkgs.xdg-utils}/bin/xdg-open";
in

# Personal machines only (not the work laptop)
lib.mkIf machine.isPersonal {
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.himalaya.enable = true;
  programs.vdirsyncer.enable = true;
  programs.khard.enable = true;
  programs.notmuch = {
    enable = true;
    settings = {
        new = {
          tags = [ "new" ];
        };
    };
    hooks = {
      preNew = "mbsync -a";
    };
  };

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
      # viewer = {
      #   alternatives = "text/html,text/plain";
      # };
      filters = {
        "text/plain" = "cat";
        "text/html" = "${pkgs.w3m}/bin/w3m -T text/html -cols $(tput cols) -dump -o display_image=false -o display_link_number=true";
      };
      openers = {
        "text/html" = "${openCmd}";
        "text/plain" = "less -R";
        "application/pdf" = "${openCmd}";
        "image/*" = "${openCmd}";
      };
    };
  };

  accounts.email = {
    maildirBasePath = "Mail";
    certificatesFile = "${builtins.getEnv "HOME"}/.nix-profile/etc/ssl/certs/ca-bundle.crt";

    accounts = {
      FastMail = {
        flavor = "fastmail.com";
        inherit (mail) address realName aliases;
        primary = true;
        folders = {
          inbox = "INBOX";
          drafts = "Drafts";
          sent = "Sent";
          trash = "Trash";
        };
        userName = mail.userName;
        gpg = {
          signByDefault = true;
          key = "AD11750151C10881970BD943AB49BD6B2B3A6377";
        };
        passwordCommand = "pass show email/fastmail";
        imap.authentication = "plain";
        smtp.authentication = "plain";
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "maildir";
        };
        notmuch.enable = true;
        msmtp.enable = true;
        aerc.enable = true;
        himalaya = {
          enable = true;
          settings = {
            backend = {
              type = "maildir";
              root-dir = "${builtins.getEnv "HOME"}/Mail/FastMail";
            };
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
          userName = mail.userName;
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
          userName = mail.userName;
        };
        vdirsyncer = {
          enable = true;
          collections = ["from a" "from b"];
        };
      };
    };
  };
}
