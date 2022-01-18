{ pkgs, ... }:

{
  home.packages = with pkgs; [ aerc vdirsyncer imapnotify ];
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.neomutt = {
    enable = true;
    sidebar.enable = true;
    sort = "reverse-threads";
  };
  programs.himalaya.enable = true;
  programs.mu.enable = true;

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
        imap.port = 993;
        smtp.host = "mail.messagingengine.com";
        smtp.port = 465;
        passwordCommand = "gpg -dq ${builtins.getEnv "HOME"}/.dustinswan@fastmail.com-password.gpg";
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "maildir";
        };
        # imapnotify = {
        #   enable = true;
        #   boxes = [ "INBOX" ];
        #   onNotify = "\${pkgs.isync}/bin/mbsync -a";
        #   onNotifyPost = { mail = "\${pkgs.noti}/bin/noti 'New mail'"; };
        # };
        mu.enable = true;
        msmtp.enable = true;
        neomutt.enable = true;
        himalaya = {
          enable = true;
          settings = {
            sent-folder = "INBOX.Sent";
            draft-folder = "INBOX.Drafts";
          };
        };
        # signature = {
        #   text = ''Dustin Swan | dustinswan.com'';
        #   showSignature = "append";
        # };
      };
    };
  };

  home.file.aerc-accounts = {
    target = ".config/aerc/accounts.conf";
    text = ''[FastMail]
source = maildir://~/Mail/FastMail
from = "Dustin Swan <dustin@dustinswan.com>"
outgoing = ${builtins.getEnv "HOME"}/.nix-profile/bin/msmtp --read-envelope-from
'';
#    text = ''[FastMail]
#source = imaps://dustinswan%40fastmail.com@mail.messagingengine.com:993
#from = "Dustin Swan <dustin@dustinswan.com>"
#outgoing = ${builtins.getEnv "HOME"}/.nix-profile/bin/msmtp --read-envelope-from
#source-cred-cmd = "gpg -dq ${builtins.getEnv "HOME"}/.dustinswan@fastmail.com-password.gpg"
#'';
  };

  home.file.vdirsyncer = {
    target = ".config/vdirsyncer/config";
    text = ''[general]
status_path = "~/.vdirsyncer/status/"

[pair fastmail_contacts]
a = "fastmail_contacts_local"
b = "fastmail_contacts_remote"
collections = ["from b"]
conflict_resolution = "b wins"

[storage fastmail_contacts_local]
type = "filesystem"
path = "~/Contacts/"
fileext = ".vcf"

[storage fastmail_contacts_remote]
type = "carddav"
url = "https://carddav.messagingengine.com/"
username = "dustinswan@fastmail.com"
password.fetch = ["command", "~/dotfiles/bin/decrypt-password", "dustinswan@fastmail.com"]

[pair fastmail_calendar]
a = "fastmail_calendar_local"
b = "fastmail_calendar_remote"
collections = ["from b"]
conflict_resolution = "b wins"
metadata = ["color", "displayname"]

[storage fastmail_calendar_local]
type = "filesystem"
path = "~/Calendars/"
fileext = ".ics"

[storage fastmail_calendar_remote]
type = "caldav"
url = "https://caldav.messagingengine.com/"
username = "dustinswan@fastmail.com"
password.fetch = ["command", "~/dotfiles/bin/decrypt-password", "dustinswan@fastmail.com"]'';
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
}
