(eval-after-load 'mu4e
  '(progn

     (setq
      user-mail-address "dustinswan@gmail.com"

      mu4e-maildir "~/Mail" ;; top-level Maildir
      mu4e-sent-folder "/Gmail/[Gmail].Sent Mail" ;; folder for sent messages
      mu4e-drafts-folder "/Gmail/[Gmail].Drafts" ;; unfinished messages
      mu4e-trash-folder "/Gmail/[Gmail].Trash" ;; trashed messages
      mu4e-refile-folder "/Gmail/[Gmail].All Mail" ;; saved messages
      mu4e-sent-messages-behavior 'delete

      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-local-domain "gmail.com" ;; what the fuck is this
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 25
      
      mu4e-get-mail-command "offlineimap -q"
      mu4e-update-interval 120
      )

     ;; (defvar my-mu4e-account-alist
     ;;   '(("Gmail"
     ;;      (mu4e-sent-folder "/Account1/Saved Items")
     ;;      (mu4e-drafts-folder "/Account1/Drafts")
     ;;      (user-mail-address "my.address@account1.tld")
     ;;      (smtpmail-default-smtp-server "smtp.account1.tld")
     ;;      (smtpmail-local-domain "account1.tld")
     ;;      (smtpmail-smtp-user "username1")
     ;;      (smtpmail-smtp-server "smtp.account1.tld")
     ;;      (smtpmail-stream-type starttls)
     ;;      (smtpmail-smtp-service 25))
     ;;     ("IOCOM"
     ;;      (mu4e-sent-folder "/Account2/Saved Items")
     ;;      (mu4e-drafts-folder "/Account2/Drafts")
     ;;      (user-mail-address "my.address@account2.tld")
     ;;      (smtpmail-default-smtp-server "smtp.account2.tld")
     ;;      (smtpmail-local-domain "account2.tld")
     ;;      (smtpmail-smtp-user "username2")
     ;;      (smtpmail-smtp-server "smtp.account2.tld")
     ;;      (smtpmail-stream-type starttls)
     ;;      (smtpmail-smtp-service 587))))

     (setq mu4e-attachment-dir "~/Downloads")

     (setq mu4e-view-show-images t) ;; enable inline images

     ;; use imagemagick, if available
     (when (fboundp 'imagemagick-register-types)
       (imagemagick-register-types))))
