;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
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
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ivy
     csv
     (version-control :variables
                      version-control-diff-side 'left
                      version-control-global-margin t)
     git
     github
     perforce
     syntax-checking
     (spell-checking :variables
                     spell-checking-enable-auto-dictionary t)
     better-defaults
     ibuffer
     (neotree :variables
              neo-theme 'icons)

     osx
     nixos
     (mu4e :variables
           mu4e-installation-path "/usr/local/share/emacs/site-lisp"
           mu4e-enable-notifications t
           mu4e-use-maildirs-extension t
           mu4e-enable-async-operations t
           mu4e-enable-mode-line t)
     (ranger :variables
             ranger-enter-with-minus t
             ranger-cleanup-eagerly t
             ranger-parent-depth 4
             ranger-max-preview-size 10
             ranger-show-literal t
             ranger-show-preview t)
     (auto-completion :variables
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-snippets-in-popup t)
     colors
     unicode-fonts
     restclient
     evil-snipe
     vinegar
     pdf
     search-engine
     dash
     ; (rcirc :variables rcirc-enable-authinfo-support t)
     (erc :variables
          erc-server-list
          '(("irc.freenode.net"
             :port "6697"
             :ssl t
             :nick "sw4n")))
     (org :variables
          org-startup-indented t
          org-hide-emphasis-markers t
          ; org-bullets-bullet-list '(" ")
          org-want-todo-bindings t
          org-enable-github-support t
          org-enable-org-journal-support t
          org-journal-enable-encryption t
          org-journal-encrypt-journal t
          org-journal-dir "~/Sync/Notes/Journal/"
          org-journal-file-format "%Y%m%d.org"
          org-journal-date-format "%A, %B %d, %Y"
          org-journal-time-format "%R %Z")
     deft
     shell
     elfeed
     finance
     emoji
     twitter
     games

     ;; Langs
     c-c++
     emacs-lisp
     common-lisp
     (haskell :variables haskell-enable-hindent-style "johan-tibell" haskell-completion-backend 'intero)
     idris
     purescript
     elm
     (javascript :variables
                 js2-basic-offset 2
                 js-indent-level 2)
     typescript
     json
     react
     html
     php
     rust
     shell-scripts
     python
     markdown
     yaml
     latex
     sql
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages
   '(
     mixed-pitch
     emms
     w3m
     elfeed-protocol
     all-the-icons
     spaceline-all-the-icons
     hackernews
     chess
     wttrin
     mingus
     writeroom-mode
     beacon
     vdirel
     circe
     nix-mode
     (vue-mode :location (recipe :fetcher github
                                 :repo "codefalling/vue-mode")))

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   ; dotspacemacs-excluded-packages '(toxi-theme wolfram-mode)
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

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

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
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
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7)
                                (bookmarks . 5))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(nord monokai spacemacs-dark spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator alternate :separator-scale 1.8)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Iosevka Nerd Font"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.5)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
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
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

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

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 95

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
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

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
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

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  (setq prettify-symbols-unprettify-at-point t)
  (global-prettify-symbols-mode +1)

  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)

  ;; ctrl-w when a completion dropdown is open
  ;(with-eval-after-load 'company
  ;  (define-key company-active-map (kbd "C-w") 'evil-delete-backward-word))
  ;(with-eval-after-load 'helm
  ;  (define-key helm-map (kbd "C-w") 'evil-delete-backward-word))

  (spacemacs/enable-transparency)
  (defun my-focus-new-frame (frame)
    (spacemacs/toggle-transparent-frame))
  (add-hook 'after-make-frame-functions 'my-focus-new-frame t)

  ; (beacon-mode 1)

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
                       (mu4e-trash-folder . "/FastMail/INBOX.Trash")))

             ,(make-mu4e-context
               :name "IOCOM"
               :enter-func (lambda () (mu4e-message "Switch to the IOCOM context"))
               ;; leave-fun not defined
               :match-func (lambda (msg)
                             (when msg
                               (string-match-p (regexp-quote "IOCOM") (mu4e-message-field msg :maildir))))
               :vars '((user-mail-address . "dswan@visionable.com")
                       (mu4e-sent-messages-behavior . sent)
                       (mu4e-sent-folder . "/IOCOM/Sent Items")
                       (mu4e-drafts-folder . "/IOCOM/Drafts")
                       (mu4e-refile-folder . "/IOCOM/INBOX.Archive") ;; Exchange is broken I think.. I can't move this
                       (mu4e-trash-folder . "/IOCOM/Deleted Items")))))

    (setq mu4e-context-policy 'pick-first)

    (setq mu4e-maildir "~/Mail"
          user-full-name "Dustin Swan"
          mu4e-user-mail-address-list '("dustin@dustinswan.com"
                                        "dustinswan@gmail.com"
                                        "dswan@visionable.com"
                                        "dswan@iocom.com"
                                        "dswan@insors.com")
          mu4e-get-mail-command "offlineimap -q"
          mu4e-update-interval 180
          mu4e-compose-signature-auto-include nil

          ;; Viewing Mail
          mu4e-headers-show-threads t
          mu4e-view-show-addresses t
          mu4e-view-show-images t
          mu4e-view-prefer-html nil
          ; mu4e-use-fancy-chars t
          mu4e-html2text-command 'mu4e-shr2text
          ;; mu4e-html2text-command "w3m -dump -T text/html"
          ;; w3m-command "/usr/local/bin/w3m"

          org-mu4e-link-query-in-headers-mode nil

          ;; Sending Mail
          mu4e-sent-messages-behavior 'sent
          message-send-mail-function 'message-send-mail-with-sendmail
          message-sendmail-extra-arguments '("--read-envelope-from")
          message-sendmail-f-is-evil t
          sendmail-program "~/.nix-profile/bin/msmtp"

          mu4e-hide-index-messages t)

    (when (fboundp 'imagemagick-register-types)
      (imagemagick-register-types))

    ;; Mail directory shortcuts
    (setq mu4e-maildir-shortcuts
          '(("/FastMail/INBOX" . ?F)
            ("/IOCOM/INBOX" . ?I)))

    ;; Bookmarks
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

    (when (spacemacs/system-is-mac)
      (with-eval-after-load 'mu4e-alert
        (mu4e-alert-set-default-style 'notifier)))

    (when (spacemacs/system-is-linux)
      (with-eval-after-load 'mu4e-alert
        (mu4e-alert-set-default-style 'notifications)))

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

  ;; Org
  (with-eval-after-load 'org
    (package-initialize)

    ;(defun my/org-mode-hook ()
    ;  "Stop the org-level headers from increasing in height relative to the other text."
    ;  (dolist (face '(org-level-1
    ;                  org-level-2
    ;                  org-level-3
    ;                  org-level-4
    ;                  org-level-5))
    ;    (set-face-attribute face nil :weight 'semi-bold :height 1.0)))

    ;(add-hook 'org-mode-hook 'my/org-mode-hook)

    ;; (setq org-agenda-files '("~/Sync/Notes")) ;; This is very slow
    (setq org-directory "~/Sync/Notes/")
    (setq org-archive-location "~/Sync/Notes/archive.org::* From %s")
    (setq org-agenda-files '("~/Sync/Notes/Main.org" "~/Sync/Notes/Schedule.org" "~/Sync/Notes/IOCOM.org" "~/Sync/Notes/Computers.org"))
    (setq org-agenda-start-day "-0d")
    (setq org-agenda-span 2)
    (setq org-agenda-sorting-strategy
       '((agenda time-up habit-down priority-down category-keep) ;; this was originally: (agenda habit-down time-up priority-down category-keep)
        (todo priority-down category-keep)
        (tags priority-down category-keep)
        (search category-keep)))
    (setq org-refile-targets '((org-agenda-files :maxlevel . 9)))
    (setq org-reverse-note-order t)
    ; (setq org-log-into-drawer t) ;; this just grows forever..
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

    ;; Crypt
    (require 'org-crypt)
    (org-crypt-use-before-save-magic)
    (setq org-tags-exclude-from-inheritance (quote ("crypt")))
    (setq org-crypt-key nil) ;; symmetric encryption
    (setq epg-gpg-program "/usr/local/bin/gpg")

    ;; Deft
    (setq deft-directory "~/Sync/Notes")
    (setq deft-recursive t)

    ;; Org Publish stuff
    (require 'ox-html)
    (require 'ox-rss)
    (require 'ox-publish)
    )

  (setq wttrin-default-cities '("Castleton on Hudson, NY" "Troy, NY" "Albuquerque, NM" "Chicago, IL"))
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))

  (setq tramp-default-method "ssh")

  (push '("*mingus" . emacs) evil-buffer-regexps)

  ; (setq twittering-use-master-password t)

  (add-hook 'rcirc-mode-hook
            (lambda ()
              (set (make-local-variable 'scroll-conservatively))))

  ;; Elfeed

  (setq elfeed-use-curl t)
  ; (elfeed-set-timeout 36000)
  ;; (setq elfeed-curl-extra-arguments '("--insecure")) ;necessary for https without a trust certificate
  (require 'elfeed-protocol)
  (setq elfeed-feeds (list (list "ttrss+https://dustinswan@tt-rss.dustinswan.com" :password "")))
  (elfeed-protocol-enable)
)
