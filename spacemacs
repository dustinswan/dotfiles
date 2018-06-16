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
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     csv
     helm
     version-control
     git
     github
     perforce
     syntax-checking
     (spell-checking :variables spell-checking-enable-auto-dictionary t)
     better-defaults
     osx
     ;; nixos
     (mu4e :variables
           mu4e-installation-path "/usr/local/share/emacs/site-lisp"
           mu4e-enable-notifications t
           mu4e-enable-mode-line t)
     (ranger :variables ranger-show-preview t)
     speed-reading
     auto-completion
     colors
     restclient
     evil-snipe
     vinegar
     search-engine
     dash
     (rcirc :variables rcirc-enable-authinfo-support t)
     (erc :variables
          erc-server-list
          '(("irc.freenode.net"
             :port "6697"
             :ssl t
             :nick "sw4n")))
     (org :variables org-enable-github-support t)
     deft
     ;; (shell :variables shell-default-term-shell "/Users/dustinswan/.nix-profile/bin/zsh")
     ;; (shell :variables shell-default-term-shell "/usr/local/bin/fish" shell-default-shell 'multi-term)
     (shell :variables shell-default-term-shell "/usr/local/bin/fish" shell-default-shell 'eshell)
     xkcd
     spotify
     finance
     ;; emoji ;; disable until https://github.com/syl20bnr/emacs-emoji-cheat-sheet-plus/issues/5 is fixed
     ;; (geolocation :variables
     ;;              geolocation-enable-osx-location-service-support t
     ;;              geolocation-enable-weather-forecast t)

     ;; Langs
     c-c++
     emacs-lisp
     common-lisp
     scheme
     (haskell :variables haskell-enable-hindent-style "johan-tibell" haskell-completion-backend 'intero)
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
     ;; pandoc ;; until pandoc 2 is in Nix unstable
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
   dotspacemacs-additional-packages
   '(
     weechat
     all-the-icons
     spaceline-all-the-icons
     hackernews
     chess
     wttrin
     mingus
     writeroom-mode
     beacon
     org-journal
     vdirel
     circe
     (vue-mode :location (recipe :fetcher github
                                 :repo "codefalling/vue-mode")))

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(toxi-theme wolfram-mode)
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
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style '(hybrid :variables
                                hybrid-mode-enable-evilified-state t
                                hybrid-mode-enable-hjkl-bindings t
                                hybrid-mode-default-state 'normal)
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7)
                                (bookmarks . 5))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(monokai spacemacs-dark ample alect-black zenburn darkburn solarized-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("Source Code Pro"
   ;; dotspacemacs-default-font '("PragmataPro"
   dotspacemacs-default-font '("Iosevka Nerd Font"
                               :size 11
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
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
   dotspacemacs-fullscreen-at-startup nil
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
   dotspacemacs-inactive-transparency 80
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
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
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  (setq-default git-magit-status-fullscreen t)
  (setq-default git-enable-github-support t)

  (add-to-list 'exec-path "~/.local/bin/")
  (add-to-list 'exec-path "~/.npm-packages/bin/")
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (require 'weechat)

  (use-package spaceline-all-the-icons
      :after spaceline
      :config
      (spaceline-all-the-icons-theme))
  (setq neo-theme 'icons)

  (setq monokai-background "#000000")

  ;; fix Fish prompts
  (add-hook 'term-mode-hook 'spacemacs/toggle-truncate-lines-on)

  ;; ctrl-w when a completion dropdown is open
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "C-w") 'evil-delete-backward-word))
  (with-eval-after-load 'helm
    (define-key helm-map (kbd "C-w") 'evil-delete-backward-word))

  (global-set-key (kbd "M-s-h") 'ns-do-hide-others) ;; TODO Take out when Spacemacs gets this
  (global-set-key [142607065] 'ns-do-hide-others) ;; TODO Take out when Spacemacs gets this

  (setq-default js2-basic-offset 2)
  (setq-default js-indent-level 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  (use-package vue-mode)

  (spacemacs/enable-transparency)

  (defun my-focus-new-frame (frame)
    (spacemacs/toggle-transparent-frame))
  (add-hook 'after-make-frame-functions 'my-focus-new-frame t)

  (spacemacs|define-custom-layout "@Haskellbook"
    :binding "H"
    :body
    (progn
      ;; open up haskellbook
      (bookmark-jump "haskellbook")
      (split-window-right-and-focus)
      ;; project root
      (bookmark-jump "haskellbook-exercise")
      (split-window-below)
      ;; repl
      (intero-repl-load)
      ;; switch back to the pdf
      (winum-select-window-1)
      (shrink-window-horizontally 20)
      ;; center it!
      (image-forward-hscroll 14)
      (doc-view-next-line-or-next-page 3)
      ))

  (spacemacs|define-custom-layout "@Mail"
    :binding "m"
    :body
      (call-interactively 'mu4e))

  (beacon-mode 1)

  (setq ns-use-srgb-colorspace nil)

  (setq powerline-default-separator 'arrow-fade)

  (setq vdirel-repository "~/Contacts/Default/")

  ;; Mail
  (with-eval-after-load 'mu4e
    (setq mu4e-contexts
          `( ,(make-mu4e-context
               :name "FastMail"
               :enter-func (lambda () (mu4e-message "Switch to the FastMail context"))
               ;; leave-func not defined
               :match-func (lambda (msg)
                             (when msg
                               (string-match-p (regexp-quote "FastMail") (mu4e-message-field msg :maildir))))
               :vars '((user-mail-address	. "dustin@dustinswan.com")
                       (mu4e-sent-messages-behavior . sent)
                       (mu4e-sent-folder . "/FastMail/INBOX.Sent")
                       (mu4e-drafts-folder . "/FastMail/INBOX.Drafts")
                       (mu4e-refile-folder . "/FastMail/INBOX.Archive")
                       (mu4e-trash-folder . "/FastMail/INBOX.Trash")
                       (user-full-name . "Dustin Swan")))

             ,(make-mu4e-context
               :name "IOCOM"
               :enter-func (lambda () (mu4e-message "Switch to the IOCOM context"))
               ;; leave-fun not defined
               :match-func (lambda (msg)
                             (when msg
                               (string-match-p (regexp-quote "IOCOM") (mu4e-message-field msg :maildir))))
               :vars '((user-mail-address . "dswan@iocom.com")
                       (mu4e-sent-messages-behavior . sent)
                       (mu4e-sent-folder . "/IOCOM/INBOX.Sent")
                       (mu4e-drafts-folder . "/IOCOM/INBOX.Drafts")
                       (mu4e-refile-folder . "/IOCOM/INBOX.Archive")
                       (mu4e-trash-folder . "/IOCOM/INBOX.Trash")
                       (user-full-name . "Dustin Swan")))))

    (setq mu4e-context-policy 'pick-first)

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
          mu4e-view-prefer-html nil
          ;; mu4e-html2text-command 'mu4e-shr2text
          mu4e-html2text-command "w3m -dump -T text/html"
          w3m-command "/usr/local/bin/w3m"

          org-mu4e-link-query-in-headers-mode nil

          ;; Sending Mail
          message-send-mail-function 'message-send-mail-with-sendmail
          message-sendmail-extra-arguments '("--read-envelope-from")
          message-sendmail-f-is-evil 't
          sendmail-program "/usr/local/bin/msmtp"

          mu4e-hide-index-messages 't)

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
  )

  (setenv "P4USER" "dswan")
  (setenv "P4PORT" "humu.insors.net:1666")
  (setenv "P4CONFIG" "p4.cfg")

  (setenv "LANG" "en_US.UTF-8")

  (setq ranger-cleanup-on-disable t
        ranger-cleanup-eagerly t
        ranger-show-literal nil
        ranger-show-dotfiles nil
        ranger-parent-depth 4
        ranger-max-preview-size 10)

  ;;(require 'tumblesocks)
  ;;(setq tumblesocks-blog "dustinswan.tumblr.com")
  ;;  (eval-after-load 'tumblesocks-view-mode
  ;;    '(progn
  ;;       ;; (define-key twittering-mode-map (kbd "g") nil)
  ;;       (define-key tumblesocks-view-mode-map (kbd "j") 'tumblesocks-view-next-post)
  ;;       (define-key tumblesocks-view-mode-map (kbd "k") 'tumblesocks-view-prev-post)
  ;;       ))

  ;; Org
  (with-eval-after-load 'org

    (package-initialize)

    (setq org-startup-indented t)

    (require 'org-drill)

    (defun my/org-mode-hook ()
      "Stop the org-level headers from increasing in height relative to the other text."
      (dolist (face '(org-level-1
                      org-level-2
                      org-level-3
                      org-level-4
                      org-level-5))
        (set-face-attribute face nil :weight 'semi-bold :height 1.0)))

    (add-hook 'org-mode-hook 'my/org-mode-hook)

    ;; (setq org-agenda-files '("~/Sync/Notes")) ;; This is very slow
    (setq org-agenda-files '("~/Sync/Notes/Main.org" "~/Sync/Notes/Schedule.org" "~/Sync/Notes/IOCOM.org" "~/Sync/Notes/Computers.org"))
    (setq org-agenda-start-day "-0d")
    (setq org-agenda-span 2)
    (setq org-agenda-sorting-strategy
       '((agenda time-up habit-down priority-down category-keep) ;; this was originally: (agenda habit-down time-up priority-down category-keep)
        (todo priority-down category-keep)
        (tags priority-down category-keep)
        (search category-keep)))
    (setq org-archive-location "~/Sync/Notes/archive.org::* From %s")

    (setq org-directory "~/Sync/Notes/")
    (setq org-refile-targets '((org-agenda-files :maxlevel . 9)))
    (setq org-reverse-note-order t)
    (setq org-log-into-drawer t)
    (add-to-list 'org-modules 'org-habit)

    (setq org-todo-keywords
          '((sequence "TODO" "IN-PROGRESS(p)" "WAITING(w@/!)" "|" "DONE(d/!)" "CANCELED(c@)")))

    ; Org-protocol
    (add-to-list 'org-modules 'org-protocol)
    (require 'org-protocol)

    (setq org-agenda-custom-commands
          '(("c" "Simple agenda view"
             ((agenda "" )
              (alltodo "")))))

    ;; Capture
    (setq org-capture-templates
          '(("t" "TODO" entry (file+headline "~/Sync/Notes/Main.org" "Inbox")
             "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
            ("i" "IOCOM TODO" entry (file+headline "~/Sync/Notes/IOCOM.org" "Inbox")
             "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
            ("r" "Read Later" entry (file+headline "~/Sync/Notes/Main.org" "Inbox")
             "* TODO Read: %a \n")))

    ;; Org Journal
    (setq org-journal-dir "~/Sync/Notes/Journal/"
          org-journal-file-format "%Y%m%d.org")
    (evil-leader/set-key "aj" 'org-journal-new-entry)
    (setq org-journal-date-format "%A, %B %d, %Y")
    (setq org-journal-time-format "%R %Z")

    (evil-leader/set-key-for-mode 'org-journal-mode
      "n" 'org-journal-open-next-entry
      "p" 'org-journal-open-previous-entry)

    (add-hook 'org-journal-mode-hook 'turn-on-auto-fill)
    (add-hook 'org-journal-mode-hook 'flyspell-mode)

    ;; Crypt
    (require 'org-crypt)
    (org-crypt-use-before-save-magic)
    (setq org-tags-exclude-from-inheritance (quote ("crypt")))
    ;; (setq org-crypt-key nil) ;; symmetric encryption

    ;; Deft
    (setq deft-directory "~/Sync/Notes")
    (setq deft-recursive t)

    ;; Org Publish stuff
    (require 'ox-html)
    (require 'ox-rss)
    (require 'ox-publish)

    )

  (setq wttrin-default-cities '("Troy NY" "Albuquerque" "Chicago"))
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))

  (setq tramp-default-method "ssh")

  (push '("*mingus" . emacs) evil-buffer-regexps)

  (setq twittering-use-master-password t)

  (add-hook 'rcirc-mode-hook
            (lambda ()
              (set (make-local-variable 'scroll-conservatively))))

  ;; Elfeed

  ;; makes sure elfeed reads index from disk before launching
  (defun bjm/elfeed-load-db-and-open ()
    "Wrapper to load the elfeed db from disk before opening"
    (interactive)
    (elfeed-db-load)
    (elfeed)
    (elfeed-search-update--force))

  ;; write to disk when quitting
  (defun bjm/elfeed-save-db-and-bury ()
    "Wrapper to save the elfeed db to disk before burying buffer"
    (interactive)
    (elfeed-db-save)
    (quit-window))

  ;; override quitting
  (evilified-state-evilify-map elfeed-search-mode-map
    :mode elfeed-search-mode
    :eval-after-load elfeed-search
    :bindings
    "q"  'bjm/elfeed-save-db-and-bury)

  (spacemacs/set-leader-keys "af" 'bjm/elfeed-load-db-and-open)
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-ispell-requires 4 t)
 '(ahs-case-fold-search nil t)
 '(ahs-default-range (quote ahs-range-whole-buffer) t)
 '(ahs-idle-interval 0.25 t)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil t)
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(compilation-message-face (quote default))
 '(erc-interpret-mirc-color t)
 '(erc-modules
   (quote
    (autoaway autojoin button completion fill irccontrols move-to-prompt netsplit notifications readonly ring scrolltobottom services smiley spelling youtube list match networks notify track autojoin log menu image hl-nicks)))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#20240E" t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#20240E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#20240E" . 100))))
 '(js-indent-level 2 t)
 '(js2-basic-offset 2 t)
 '(mac-auto-operator-composition-mode t)
 '(magit-diff-use-overlays nil)
 '(monokai-use-variable-pitch nil)
 '(ns-auto-hide-menu-bar nil)
 '(org-journal-date-format "%A, %B %d, %Y")
 '(org-journal-time-format "%R %Z")
 '(package-selected-packages
   (quote
    (weechat restclient-helm helm-spotify-plus tracking symon org-mime elfeed-web elfeed-org elfeed-goodies ace-jump-mode noflet elfeed hledger-mode let-alist ghub zeal-at-point edit-indirect ssass-mode vue-html-mode org-vcard oauth gntp libmpdee json-snatcher json-reformat prop-menu parent-mode fringe-helper git-gutter+ git-gutter marshal logito ht pos-tip flx anzu goto-chg pkg-info epl web-completion-data dash-functional seq pythonic popup dash-at-point counsel-dash helm-dash visual-fill-column org-category-capture ghc undo-tree s spaceline-all-the-icons all-the-icons memoize font-lock+ diminish pdf-tools tablist f winum unfill sudoku ob-restclient multiple-cursors fuzzy company-restclient know-your-http-well flyspell-correct log4e async mmt slime rust-mode bind-key packed auto-complete avy tern iedit bind-map evil simple-httpd pcache alert php-mode purescript-mode haml-mode markdown-mode htmlize vue-mode circe rcirc-notify rcirc-color helm-themes helm-swoop helm-spotify multi helm-pydoc helm-projectile helm-mode-manager helm-hoogle helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag flyspell-correct-helm ace-jump-helm-line csv-mode inflections spinner org anaconda-mode swiper highlight projectile skewer-mode js2-mode gh magit-popup git-commit hydra inf-ruby pcre2el macrostep dash powerline auctex counsel smartparens go-mode haskell-mode flycheck magit with-editor yasnippet rake company ivy helm helm-core xterm-color auctex-latexmk yapfify yaml-mode xkcd wttrin ws-butler writeroom-mode wolfram-mode window-numbering which-key wgrep web-mode web-beautify volatile-highlights vi-tilde-fringe vdirel uuidgen use-package typit twittering-mode tumblesocks toml-mode toc-org thrift tagedit stan-mode spray spotify spacemacs-theme spaceline smex smeargle slime-company slim-mode shell-pop scss-mode scad-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reveal-in-osx-finder restclient restart-emacs request rbenv ranger rainbow-mode rainbow-identifiers rainbow-delimiters racer quelpa qml-mode pyvenv pytest pyenv-mode py-isort pug-mode psci psc-ide projectile-rails popwin pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode pbcopy paradox pandoc-mode pacmacs p4 ox-pandoc ox-gfm osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-plus-contrib org-journal org-download org-bullets open-junk-file ob-http neotree mwim multi-term mu4e-maildirs-extension mu4e-alert move-text monokai-theme mmm-mode minitest mingus matlab-mode markdown-toc magit-gitflow magit-gh-pulls lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode ledger-mode launchctl julia-mode json-mode js2-refactor js-doc ivy-hydra intero insert-shebang info+ indent-guide idris-mode ido-vertical-mode hy-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-make haskell-snippets hackernews google-translate golden-ratio go-guru go-eldoc gnuplot gitignore-mode github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gist gh-md geiser flyspell-correct-ivy flycheck-rust flycheck-pos-tip flycheck-ledger flycheck-haskell flycheck-elm flx-ido fish-mode fill-column-indicator feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help erc-yt erc-view-log erc-terminal-notifier erc-social-graph erc-image erc-hl-nicks engine-mode emoji-cheat-sheet-plus emmet-mode elm-mode elisp-slime-nav dumb-jump drupal-mode disaster diff-hl deft cython-mode counsel-projectile company-web company-tern company-statistics company-shell company-go company-ghci company-ghc company-emoji company-cabal company-c-headers company-auctex company-anaconda common-lisp-snippets column-enforce-mode color-identifiers-mode coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format chruby chess cargo bundler bracketed-paste beacon auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile arduino-mode aggressive-indent adaptive-wrap ace-window ace-link ac-ispell 2048-game)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(psc-ide-add-import-on-completion t t)
 '(psc-ide-rebuild-on-save nil t)
 '(ring-bell-function (quote ignore))
 '(spaceline-all-the-icons-separator-type (quote arrow))
 '(spaceline-info-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#20240E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 257)) (:foreground "#F8F8F2" :background "#272822" :family "Iosevka" :foundry "nil" :slant normal :weight normal :height 130 :width normal)) (((class color) (min-colors 89)) (:foreground "#F5F5F5" :background "#1B1E1C" :family "Iosevka" :foundry "nil" :slant normal :weight normal :height 130 :width normal))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
