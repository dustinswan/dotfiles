(eval-after-load 'mu4e
  '(progn
     (setq
      mu4e-maildir "~/Mail" ;; top-level Maildir
      mu4e-sent-folder "/Gmail/[Gmail].Sent Mail" ;; folder for sent messages
      mu4e-drafts-folder "/Gmail/[Gmail].Drafts" ;; unfinished messages
      mu4e-trash-folder "/Gmail/[Gmail].Trash" ;; trashed messages
      mu4e-refile-folder "/Gmail/[Gmail].Archive" ;; saved messages
      mu4e-get-mail-command "offlineimap -q"
      mu4e-update-interval 120
      )

     (setq mu4e-attachment-dir "~/Downloads")

     ;; enable inline images
     (setq mu4e-view-show-images t)

     ;; use imagemagick, if available
     (when (fboundp 'imagemagick-register-types)
       (imagemagick-register-types))))
