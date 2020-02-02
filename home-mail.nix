{ pkgs, ... }:

{
  home.file.aerc-accounts = {
    target = ".config/aerc/accounts.conf";
    # source = ./aerc-accounts.conf;
    text = ''[FastMail]
source = maildir://~/Mail/FastMail
from = "Dustin Swan <dustin@dustinswan.com>"
outgoing = ${builtins.getEnv "HOME"}/.nix-profile/bin/msmtp --read-envelope-from

[Visionable]
source = maildir://~/Mail/Visionable
from = "Dustin Swan <dswan@visionable.com>"
outgoing = ${builtins.getEnv "HOME"}/.nix-profile/bin/msmtp --read-envelope-from'';
    executable = false;
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

      Visionable = {
        address = "dswan@visionable.com";
        aliases= "dswan@iocom.com";
        realName = "Dustin Swan";
        folders = {
          inbox = "INBOX";
          drafts = "Drafts";
          sent = "Sent Items";
          trash = "Deleted Items";
        };
        userName = "dswan@visionable.com";
        imap.host = "outlook.office365.com";
        smtp.host = "smtp.office365.com";
        passwordCommand = "gpg -dq ${builtins.getEnv "HOME"}/.dswan@visionable.com-password.gpg";
        offlineimap = {
          enable = true;
          extraConfig.remote = {
            folderfilter = ''lambda folder: folder not in [
              'Calendar',
              'Calendar/Birthdays',
              'Calendar/IOCOM Holidays',
              'Calendar/United States holidays',
              'Contacts',
              'Contacts/Sub Folder 1',
              'Contacts/Sub Folder 2',
              'Contacts/Skype for Business Contacts',
              'Deleted Items',
              'Drafts',
              'Journal',
              'Junk Email',
              'Notes',
              'Outbox',
              'Sync Issues',
              'Sync Issues/Conflicts',
              'Sync Issues/Local Failures',
              'Sync Issues/Server Failures',
              'Tasks',
              'Tasks/Sub Folder 1',
              'Tasks/Sub Folder 2'
              ]
            '';
          };
        };

        msmtp.enable = true;
        neomutt.enable = true;
        signature = {
          text = ''
            Dustin Swan, Software Developer
            Visionable Ltd | https://visionable.com
            dswan@visionable.com
          '';
          showSignature = "append";
        };
      };
    };
  };
}
