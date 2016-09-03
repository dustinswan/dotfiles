;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(version-control
     git
     github
     perforce
     syntax-checking
     (spell-checking :variables spell-checking-enable-auto-dictionary t)
     better-defaults
     osx
     ;; nixos
     (mu4e :variables mu4e-installation-path "/usr/local/share/emacs/site-lisp/mu/mu4e" mu4e-enable-notifications t mu4e-enable-mode-line t)
     (ranger :variables ranger-show-preview t)
     speed-reading
     auto-completion
     colors
     restclient
     evil-snipe
     vinegar
     search-engine
     (erc :variables
          erc-server-list
          '(("irc.freenode.net"
             :port "6697"
             :ssl t
             :nick "dustinswan")))
     (org :variables org-enable-github-support t)
     deft
     ;; (shell :variables shell-default-term-shell "/Users/dustinswan/.nix-profile/bin/zsh")
     (shell :variables shell-default-term-shell "/usr/local/bin/zsh" shell-default-shell 'multi-term)
     xkcd
     spotify
     finance
     emoji
     ;; (geolocation :variables
     ;;              geolocation-enable-osx-location-service-support t
     ;;              geolocation-enable-weather-forecast t)

     ;; Langs
     c-c++
     emacs-lisp
     common-lisp
     scheme
     (haskell :variables haskell-enable-hindent-style "fundamental")
     idris
     purescript
     elm
     javascript
     react
     html
     php
     rust
     go
     shell-scripts
     ruby
     ruby-on-rails
     python
     markdown
     pandoc
     yaml
     extra-langs
     latex
     twitter
     games
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(hackernews chess wttrin mingus tumblesocks writeroom-mode beacon org-journal vdirel)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(toxi-theme)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'hybrid
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents bookmarks projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(monokai ample alect-black spacemacs-dark zenburn darkburn solarized-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("Source Code Pro"
   ;; dotspacemacs-default-font '("PragmataPro"
   dotspacemacs-default-font '("Hasklig"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup t
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native t
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."
  (setq-default git-magit-status-fullscreen t)
  (setq-default git-enable-github-support t)

  (add-to-list 'exec-path "~/.local/bin/")
  (add-to-list 'exec-path "~/.npm-packages/bin/")
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."

  (beacon-mode 1)

  (setq ns-use-srgb-colorspace nil)

  (setq powerline-default-separator 'arrow-fade)

  (setq vdirel-repository "~/Contacts/Default/")

  ;; Mail
  (setq mu4e-account-alist
        '(("FastMail"
           (mu4e-sent-messages-behavior sent)
           (mu4e-sent-folder "/FastMail/INBOX.Sent")
           (mu4e-drafts-folder "/FastMail/INBOX.Drafts")
           (mu4e-refile-folder "/FastMail/INBOX.Archive")
           (mu4e-trash-folder "/FastMail/INBOX.Trash")
           (user-mail-address "dustin@dustinswan.com"))
          ("IOCOM"
           (mu4e-sent-messages-behavior sent)
           (mu4e-sent-folder "/IOCOM/INBOX.Sent")
           (mu4e-drafts-folder "/IOCOM/INBOX.Drafts")
           (mu4e-refile-folder "/IOCOM/INBOX.Archive")
           (mu4e-trash-folder "/IOCOM/INBOX.Trash")
           (user-mail-address "dswan@iocom.com"))))

  (mu4e/mail-account-reset)

  (require 'mu4e-contrib)
  (setq mu4e-maildir "~/Mail"
        user-full-name "Dustin Swan"
        mu4e-user-mail-address-list '("dustin@dustinswan.com"
                                      "dustinswan@gmail.com"
                                      "dswan@iocom.com"
                                      "dswan@insors.com")
        mu4e-get-mail-command "offlineimap -q"
        mu4e-update-interval 180
        mu4e-compose-signature-auto-include nil

        ;; Viewing Mail
        mu4e-headers-show-threads t
        mu4e-attachment-dir "~/Downloads"
        mu4e-view-show-addresses t
        mu4e-view-show-images t
        mu4e-view-prefer-html t
        ;; mu4e-html2text-command 'mu4e-shr2text
        mu4e-html2text-command "w3m -dump -T text/html"
        w3m-command "/usr/local/bin/w3m"

        ;; Sending Mail
        message-send-mail-function 'message-send-mail-with-sendmail
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-sendmail-f-is-evil 't
        sendmail-program "/usr/local/bin/msmtp"
        )

  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  ;;; Mail directory shortcuts
  (setq mu4e-maildir-shortcuts
        '(("/FastMail/INBOX" . ?F)
          ("/IOCOM/INBOX" . ?I)))

  ;;; Bookmarks
  (setq mu4e-bookmarks
        `(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
          ("date:today..now" "Today's messages" ?t)
          ("date:7d..now" "Last 7 days" ?w)
          ("mime:image/*" "Messages with images" ?p)
          (,(mapconcat 'identity
                       (mapcar
                        (lambda (maildir)
                          (concat "maildir:" (car maildir)))
                        mu4e-maildir-shortcuts) " OR ")
                    "All inboxes" ?i)))

  (setq message-kill-buffer-on-exit t)

  (with-eval-after-load 'mu4e-alert
    (mu4e-alert-set-default-style 'notifier))

  (setq mu4e-alert-interesting-mail-query
        (concat
         "flag:unread"
         " AND NOT flag:trashed"
         " AND (maildir:/Fastmail/INBOX"
         " OR maildir:/IOCOM/INBOX)"
         ))

  (setenv "P4USER" "dswan")
  (setenv "P4PORT" "humu.insors.net:1666")
  (setenv "P4CONFIG" "p4.cfg")

  (setenv "LANG" "en_US.UTF-8")
  
  ;; (setq exec-path (append exec-path '("~/.nix-profile/bin")))


  ;; (when (configuration-layer/layer-usedp 'haskell)
  ;;   (add-hook 'haskell-interactive-mode-hook
  ;;             (lambda ()
  ;;               (setq-local evil-move-cursor-back nil))))

  ;; Time & Date in mode-line
  ;; (spaceline-define-segment date-time-segment
  ;;   (format-time-string "%a %Y/%m/%d %H:%M"))
  ;; (add-to-list 'spaceline-right 'date-time-segment)

  (fancy-battery-mode)

  ;(org-babel-do-load-languages
  ; 'org-babel-load-languages
  ; '((haskell . t)
  ;   (emacs-lisp . t)
  ;   (python . t)
  ;   ))

  (setq ranger-cleanup-on-disable t
        ranger-cleanup-eagerly t
        ranger-show-literal nil
        ranger-show-dotfiles nil
        ranger-parent-depth 4
        ranger-max-preview-size 10)

  (require 'tumblesocks)
  (setq tumblesocks-blog "dustinswan.tumblr.com")
  ;;  (eval-after-load 'tumblesocks-view-mode
  ;;    '(progn
  ;;       ;; (define-key twittering-mode-map (kbd "g") nil)
  ;;       (define-key tumblesocks-view-mode-map (kbd "j") 'tumblesocks-view-next-post)
  ;;       (define-key tumblesocks-view-mode-map (kbd "k") 'tumblesocks-view-prev-post)
  ;;       ))

  ;; Org
  (with-eval-after-load 'org

    (setq org-agenda-files '("~/Sync/Notes"
                             "~/Sync/org.org"
                             "~/Sync/IOCOM/IOCOM.org"))
    (setq org-directory "~/Sync/Notes/")

    ;; Org Journal
    (setq org-journal-dir "~/Sync/Notes/"
          org-journal-file-format "%Y%m%d.org")
    (evil-leader/set-key "aj" 'org-journal-new-entry)
    (setq org-journal-date-format "%A, %B %d, %Y")
    (setq org-journal-time-format "%R %Z")

    (evil-leader/set-key-for-mode 'org-journal-mode
      "mn" 'org-journal-open-next-entry
      "mp" 'org-journal-open-previous-entry)

    (add-hook 'org-journal-mode-hook 'turn-on-auto-fill)
    (add-hook 'org-journal-mode-hook 'flyspell-mode)

    ;; Deft
    (setq deft-directory "~/Sync/Notes")

    ;; Org Publish stuff
    (require 'ox-html)
    (require 'ox-rss)
    (require 'ox-publish)

    (setq web-bio
          "<div class='bio'>
      <img src='static/avatar.png'></img>
      <h1>Dustin Swan</h1>
      <p>Software Engineer at IOCOM. JavaScript, Haskell, functional programming, design, piano, motorcycles, languages, games, bikes, books, fashion, minimalism, spreadsheets, travel, etc.</p>
      <h5>Moriarty, NM | Chicago, IL</h5>
      <a href='mailto://dustin@dustinswan.com'><i class='fa fa-envelope'></i></a>
      <a href='https://twitter.com/dustinswan'><i class='fa fa-twitter'></i></a>
      <a href='http://github.com/dustinswan'><i class='fa fa-github'></i></a>
      <a href='http://facebook.com/dustinswan'><i class='fa fa-facebook-official'></i></a>
      <a href='http://instagram.com/dustinswan'><i class='fa fa-instagram'></i></a>
      <a href='http://dustinswan.tumblr.com'><i class='fa fa-tumblr'></i></a>
      <a href='http://pinterest.com/dustinswan'><i class='fa fa-pinterest'></i></a>
      <a href='http://reddit.com/user/dustinswan'><i class='fa fa-reddit-square'></i></a>
      <a href='https://www.coinbase.com/dustinswan'><i class='fa fa-bitcoin'></i></a>
      <a href='https://keybase.io/dustinswan'><i class='fa fa-key'></i></a>
      </div>"
          )

    (setq org-publish-project-alist
          `(("web"
             :components ("blog" "pages" "static"))
            ("pages"
             :base-directory "~/Sync/Web/pages/"
             :base-extension "org"
             :html-extension "html"
             :publishing-directory "~/Desktop/Web"
             :publishing-function org-html-publish-to-html

             :html-head-include-default-style nil
             :html-head-include-scripts nil
             :with-toc nil
             :section-numbers nil
             :html-head "<link rel=\"stylesheet\" href=\"static/style.css\" /><link rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css\">"
             :html-head-extra ""
             :html-preamble ,web-bio
             :html-postamble nil
             )
            ("blog"
             :base-directory "~/Sync/Web/blog"
             :base-extension "org"
             :html-extension "html"
             :publishing-directory "~/Desktop/Web/blog"
             :publishing-function org-html-publish-to-html
             :recursive t

             :html-head-include-default-style nil
             :html-head-include-scripts nil
             :with-toc nil
             :section-numbers nil
             ;; :with-latex t         ; do use MathJax for awesome formulas!
             :html-head "<link rel=\"stylesheet\" href=\"../static/style.css\" /><link rel=\"stylesheet\" href=\"//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css\">"
             :html-head-extra ""
             :html-preamble ,web-bio
             :html-postamble nil

             :auto-sitemap t
             :sitemap-filename "archive.org"
             :sitemap-title "Archive"
             :sitemap-sort-files anti-chronologically
             :sitemap-style list
             )
            ("static"
             :base-directory "~/Sync/Web/static"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|otf"
             :publishing-directory "~/Desktop/Web/static"
             :recursive t
             :publishing-function org-publish-attachment
             )))
    )

  (setq wttrin-default-cities '("Moriarty NM" "Albuquerque" "Chicago"))

  (setq tramp-default-method "ssh")

  (push '("*mingus" . emacs) evil-buffer-regexps)

  (setq twittering-use-master-password t)
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-ispell-requires 4 t)
 '(ahs-case-fold-search nil)
 '(ahs-default-range (quote ahs-range-whole-buffer))
 '(ahs-idle-interval 0.25)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil)
 '(erc-modules
   (quote
    (autoaway button completion list match move-to-prompt netsplit networks notify notifications readonly scrolltobottom services smiley spelling track completion autoaway autojoin button log match menu move-to-prompt netsplit notify notifications readonly ring scrolltobottom spelling track image hl-nicks networks services)))
 '(fancy-battery-mode t)
 '(js2-basic-offset 2)
 '(mac-auto-operator-composition-mode t)
 '(org-journal-date-format "%A, %B %d, %Y")
 '(org-journal-time-format "%R %Z")
 '(paradox-github-token t)
 '(ring-bell-function (quote ignore) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 257)) (:foreground "#F8F8F2" :background "#272822")) (((class color) (min-colors 89)) (:foreground "#F5F5F5" :background "#1B1E1C"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
