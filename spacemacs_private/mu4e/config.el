(eval-after-load 'mu4e
  '(progn

     (require 'mu4e-multi)
     (require 'mu4e-contrib)

     (setq mu4e-multi-account-alist
           '(("Gmail"
              (user-mail-address . "dustinswan@gmail.com")
              (mu4e-drafts-folder . "/Gmail/[Gmail].Drafts")
              (mu4e-refile-folder . "/Gmail/[Gmail].All Mail")
              (mu4e-sent-folder . "/Gmail/[Gmail].Sent Mail")
              (mu4e-trash-folder . "/Gmail/[Gmail].Trash"))
             ("IOCOM"
              (user-mail-address . "dswan@iocom.com")
              (mu4e-drafts-folder . "/IOCOM/INBOX.Drafts")
              (mu4e-refile-folder . "/IOCOM/INBOX.Archive")
              (mu4e-sent-folder . "/IOCOM/INBOX.Sent")
              (mu4e-trash-folder . "/IOCOM/INBOX.Trash"))))

     (mu4e-multi-enable)

     (global-set-key (kbd "C-x m") 'mu4e-multi-compose-new)

     ;; (add-hook 'message-send-mail-hook 'mu4e-multi-smtpmail-set-msmtp-account)

     (setq

      mu4e-maildir "~/Mail"
      mu4e-user-mail-address-list '("dustinswan@gmail.com"
                                    "dswan@iocom.com"
                                    "dswan@insors.com"
                                    "dustin@dustinswan.com")

      user-full-name  "Dustin Swan"
      mu4e-attachment-dir "~/Downloads"
      message-signature "Dustin Swan"
      mu4e-compose-signature "Dustin Swan"
      mail-host-address "gmail.com"

      mu4e-get-mail-command "offlineimap -q"
      mu4e-update-interval 120

      ;; mu4e-use-fancy-chars t

      ;; mu4e-html2text-command "html2text -nobs"
      ;; mu4e-html2text-command "w3m -T text/html"
      mu4e-html2text-command 'mu4e-shr2text
      mu4e-view-prefer-html t ;; sorryboutit
      mu4e-view-show-images t ;; doesn't work with shr2text

      message-send-mail-function 'message-send-mail-with-sendmail
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-sendmail-f-is-evil t
      message-kill-buffer-on-exit t
      sendmail-program "/usr/local/bin/msmtp"

      ;; just Gmail at first
      ;; user-mail-address "dustinswan@gmail.com"
      ;; mu4e-sent-folder "/Gmail/[Gmail].Sent Mail"
      ;; mu4e-drafts-folder "/Gmail/[Gmail].Drafts"
      ;; mu4e-trash-folder "/Gmail/[Gmail].Trash"
      ;; mu4e-refile-folder "/Gmail/[Gmail].All Mail"
      ;; mu4e-sent-messages-behavior 'delete
      ;; mail-host-address "gmail.com"

      )

     ; multiple accounts
     ;; (defvar my-mu4e-account-alist
     ;;   '(("Gmail"
     ;;      (user-mail-address "dustinswan@gmail.com")
     ;;      (mu4e-sent-folder "/Gmail/[Gmail].Sent Mail")
     ;;      (mu4e-drafts-folder "/Gmail/[Gmail].Drafts")
     ;;      (mu4e-trash-folder "/Gmail/[Gmail].Trash")
     ;;      ;; (mu4e-refile-folder "/Gmail/[Gmail].All Mail")
     ;;      (mu4e-sent-messages-behavior 'delete)
     ;;      (mail-host-address "gmail.com")

     ;;     ("IOCOM"
     ;;      (user-mail-address "dswan@iocom.com")
     ;;      (mu4e-sent-folder "/IOCOM/INBOX.Sent")
     ;;      (mu4e-drafts-folder "/IOCOM/INBOX.Drafts")
     ;;      (mu4e-trash-folder "/IOCOM/INBOX.Trash")
     ;;      ;; (mu4e-refile-folder "/IOCOM/INBOX.Archive")
     ;;      (mu4e-sent-messages-behavior 'sent)
     ;;      (mail-host-address "iocom.com")))))

     (add-to-list 'mu4e-bookmarks '("maildir:/IOCOM/INBOX OR maildir:/Gmail/INBOX" "All Inboxes" ?I))
     (add-to-list 'mu4e-bookmarks '("maildir:/IOCOM/INBOX" "IOCOM Inbox" ?i))
     (add-to-list 'mu4e-bookmarks '("maildir:/Gmail/INBOX" "Gmail Inbox" ?g))

     ;; refile
     ;; (setq mu4e-refile-folder
     ;;       (lambda (msg)
     ;;         (cond
     ;;          ((mu4e-message-contact-field-matches msg :to "dustinswan@gmail.com")
     ;;           "/Gmail/[Gmail].All Mail")
     ;;          ((mu4e-message-contact-field-matches msg :to "dswan@iocom.com")
     ;;           "/IOCOM/INBOX.Archive")
     ;;          ;; messages sent by me go to the sent folder
     ;;          ;; ((find-if
     ;;          ;;   (lambda (addr)
     ;;          ;;     (mu4e-message-contact-field-matches msg :from addr))
     ;;          ;;   mu4e-user-mail-address-list)
     ;;          ;; mu4e-sent-folder)
     ;;          (t  "/Gmail/[Gmail].All Mail"))))

     (add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

     (add-hook 'mu4e-index-updated-hook
               (lambda ()
                 (shell-command (concat "youve_got_mail "
                                        (number-to-string mu4e-update-interval)))))

     ;; use imagemagick, if available
     (when (fboundp 'imagemagick-register-types)
       (imagemagick-register-types))))

