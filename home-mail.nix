{ pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.himalaya.enable = true;
  # programs.notmuch.enable = true;
  programs.aerc.enable = true;
  programs.aerc.extraConfig.general.unsafe-accounts-conf = true;
  programs.khal.enable = true;
  programs.khard.enable = true;
  programs.vdirsyncer.enable = true;

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
        # notmuch.enable = true;
        msmtp.enable = true;
        aerc.enable = true;
        himalaya = {
          enable = true;
          settings = {
            # backend = "imap";
            # maildir.root-dir = "/Users/dustinswan/Mail/FastMail";
            message.send.backend = "smtp";
            # sent-folder = "Sent";
            # draft-folder = "Drafts";
          };
        };
        signature = {
          text = ''Dustin Swan | dustinswan.com'';
          showSignature = "append";
        };
      };

      MajorRocket = {
        flavor = "gmail.com";
        address = "dustin@majorrocket.com";
        realName = "Dustin Swan";
        primary = false;
        folders = {
          inbox = "Inbox";
          drafts = "[Gmail]/Drafts";
          sent = "[Gmail]/Sent Mail";
          trash = "[Gmail]/Trash";
        };
        userName = "dustin@majorrocket.com";
        passwordCommand = "gpg -dq ${builtins.getEnv "HOME"}/.dustin@majorrocket.com-password.gpg";
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "maildir";
        };
        msmtp.enable = true;
        # notmuch.enable = true;
        aerc.enable = true;
        # himalaya = {
        #   enable = true;
        # };
        signature = {
          text = ''Dustin Swan | Major Rocket'';
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
          passwordCommand = ["~/dotfiles/bin/decrypt-password" "dustinswan@fastmail.com"];
          type = "caldav";
          url = "https://caldav.fastmail.com/";
          userName = "dustinswan@fastmail.com";
        };
        vdirsyncer = {
          enable = true;
        };
      };
    };
  };
}

# TODO: home-manager now supports all this, don't need to do custom config files

# 
#   home.file.vdirsyncer = {
#     target = ".config/vdirsyncer/config";
#     text = ''[general]
# status_path = "~/.vdirsyncer/status/"
# 
# [pair fastmail_contacts]
# a = "fastmail_contacts_local"
# b = "fastmail_contacts_remote"
# collections = ["from b"]
# conflict_resolution = "b wins"
# 
# [storage fastmail_contacts_local]
# type = "filesystem"
# path = "~/Contacts/"
# fileext = ".vcf"
# 
# [storage fastmail_contacts_remote]
# type = "carddav"
# url = "https://carddav.messagingengine.com/"
# username = "dustinswan@fastmail.com"
# password.fetch = ["command", "~/dotfiles/bin/decrypt-password", "dustinswan@fastmail.com"]
# 
# 
# [pair fastmail_calendar]
# a = "fastmail_calendar_local"
# b = "fastmail_calendar_remote"
# collections = ["from b"]
# conflict_resolution = "b wins"
# metadata = ["color", "displayname"]
# 
# [storage fastmail_calendar_local]
# type = "filesystem"
# path = "~/Calendars/Fastmail"
# fileext = ".ics"
# 
# [storage fastmail_calendar_remote]
# type = "caldav"
# url = "https://caldav.messagingengine.com/"
# username = "dustinswan@fastmail.com"
# password.fetch = ["command", "~/dotfiles/bin/decrypt-password", "dustinswan@fastmail.com"]
# 
# 
# [pair google_calendar]
# a = "google_calendar_local"
# b = "google_calendar_remote"
# collections = null
# # conflict_resolution = "b wins"
# # metadata = ["color", "displayname"]
# 
# [storage google_calendar_local]
# type = "filesystem"
# path = "~/Calendars/Google"
# fileext = ".ics"
# 
# [storage google_calendar_remote]
# type = "http"
# url = "${secrets.google-calendar.our-stuff}"
# # type = "google_calendar"
# # token_file = "~/token_file"
# # client_id = "${secrets.google-vdirsyncer.id}"
# # client_secret = "${secrets.google-vdirsyncer.secret}"
# '';
#   };
# 
#   home.file.khard = {
#     target = ".config/khard/khard.conf";
#     text = ''[addressbooks]
# [[contacts]]
# path = ~/Contacts/Default
# 
# [general]
# default_action = list'';
#   };
# 
#   home.file.khal = {
#     target = ".config/khal/config";
#     text = ''[calendars]
# [[Fastmail]]
# path = ~/Calendars/Fastmail/*
# color = light green
# type = discover
# 
# [[Google]]
# path = ~/Calendars/Google
# color = light blue
# type = discover
# 
# [locale]
# timeformat = %H:%M
# dateformat = %Y-%m-%d
# longdateformat = %Y-%m-%d
# datetimeformat = %Y-%m-%d %H:%M
# longdatetimeformat = %Y-%m-%d %H:%M'';
#   };
