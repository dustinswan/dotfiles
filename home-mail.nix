{ pkgs, ... }:

{
  home.file.aerc-accounts = {
    target = ".config/aerc/accounts.conf";
    text = ''[FastMail]
source = maildir://~/Mail/FastMail
from = "Dustin Swan <dustin@dustinswan.com>"
outgoing = ${builtins.getEnv "HOME"}/.nix-profile/bin/msmtp --read-envelope-from
'';
#     text = ''[FastMail]
# source = imaps://dustinswan%40fastmail.com@mail.messagingengine.com:993
# from = "Dustin Swan <dustin@dustinswan.com>"
# outgoing = ${builtins.getEnv "HOME"}/.nix-profile/bin/msmtp --read-envelope-from
# sourc-cred-cmd = "gpg -dq ${builtins.getEnv "HOME"}/.dustinswan@fastmail.com-password.gpg"
# '';
  };

  home.file.khard = {
    target = ".config/khard/config";
    text = ''[addressbooks]
[[contacts]]
path = ~/Contacts/Default'';
  };

  home.file.khal = {
    target = ".config/khal/config";
    text = ''[calendars]
[[Fastmail]]
path = ~/Calendars/*
type = discover

[locale]
timeformat = %H:%M
dateformat = %Y-%m-%d
longdateformat = %Y-%m-%d
datetimeformat = %Y-%m-%d %H:%M
longdatetimeformat = %Y-%m-%d %H:%M'';
  };

  programs.neomutt = {
    enable = true;
    sidebar.enable = true;
    sort = "reverse-threads";
  };

  accounts.email = {
    maildirBasePath = "Mail";
    certificatesFile = "${builtins.getEnv "HOME"}/.nix-profile/etc/ssl/certs/ca-bundle.crt";

    accounts = {
      FastMail = {
        address = "dustin@dustinswan.com";
        aliases = "dustinswan@gmail.com";
        realName = "Dustin Swan";
        primary = true;
        folders = {
          inbox = "INBOX";
          drafts = "INBOX.Drafts";
          sent = "INBOX.Sent";
          trash = "INBOX.Trash";
        };
        userName = "dustinswan@fastmail.com";
        imap.host = "mail.messagingengine.com";
        smtp.host = "mail.messagingengine.com";
        passwordCommand = "gpg -dq ${builtins.getEnv "HOME"}/.dustinswan@fastmail.com-password.gpg";
        offlineimap.enable = true;
        msmtp.enable = true;
        neomutt.enable = true;
        signature = {
          text = ''
            Dustin Swan
            dustinswan.com
          '';
          showSignature = "append";
        };
      };
    };
  };
}
