{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  home.packages = with pkgs; [ vdirsyncer khard khal imapnotify ];

  programs.mbsync.enable = true;

  programs.msmtp.enable = true;

  # programs.himalaya.enable = true;

  programs.mu.enable = true;

  accounts.email = {
    maildirBasePath = "Mail";
    certificatesFile = "${builtins.getEnv "HOME"}/.nix-profile/etc/ssl/certs/ca-bundle.crt";

    accounts = {
      FastMail = {
        address = "dustin@dustinswan.com";
        aliases = [ "dustinswan@gmail.com" ];
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
        himalaya = {
          enable = true;
          settings = {
            backend = "maildir";
            message.send.backend = "smtp";
            sent-folder = "INBOX.Sent";
            draft-folder = "INBOX.Drafts";
          };
        };
        signature = {
          text = ''Dustin Swan | dustinswan.com'';
          showSignature = "append";
        };
      };
    };
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
path = "~/Calendars/Fastmail"
fileext = ".ics"

[storage fastmail_calendar_remote]
type = "caldav"
url = "https://caldav.messagingengine.com/"
username = "dustinswan@fastmail.com"
password.fetch = ["command", "~/dotfiles/bin/decrypt-password", "dustinswan@fastmail.com"]


[pair google_calendar]
a = "google_calendar_local"
b = "google_calendar_remote"
collections = null
# conflict_resolution = "b wins"
# metadata = ["color", "displayname"]

[storage google_calendar_local]
type = "filesystem"
path = "~/Calendars/Google"
fileext = ".ics"

[storage google_calendar_remote]
type = "http"
url = "${secrets.google-calendar.our-stuff}"
# type = "google_calendar"
# token_file = "~/token_file"
# client_id = "${secrets.google-vdirsyncer.id}"
# client_secret = "${secrets.google-vdirsyncer.secret}"
'';
  };

  home.file.khard = {
    target = ".config/khard/khard.conf";
    text = ''[addressbooks]
[[contacts]]
path = ~/Contacts/Default

[general]
default_action = list'';
  };

  home.file.khal = {
    target = ".config/khal/config";
    text = ''[calendars]
[[Fastmail]]
path = ~/Calendars/Fastmail/*
color = light green
type = discover

[[Google]]
path = ~/Calendars/Google
color = light blue
type = discover

[locale]
timeformat = %H:%M
dateformat = %Y-%m-%d
longdateformat = %Y-%m-%d
datetimeformat = %Y-%m-%d %H:%M
longdatetimeformat = %Y-%m-%d %H:%M'';
  };
}
