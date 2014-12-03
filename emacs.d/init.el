
(require 'package)

; Cask & Pallet
(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el") ;TODO this path sucks
(cask-initialize)
(require 'pallet)
(pallet-mode t)

; Evil
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key "b" 'switch-to-buffer)
(evil-leader/set-key "h" 'dired-jump)
(evil-leader/set-key "v" 'split-window-right)
(evil-leader/set-key "," 'other-window)
(evil-define-key 'normal emacs-lisp-mode-map (kbd "K") 'elisp-slime-nav-describe-elisp-thing-at-point)

(require 'evil)
(evil-mode 1)

; Ido
(require 'ido)
(ido-mode t)

; Js2
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

; Slime
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(require 'slime)

(require 'elisp-slime-nav)
(defun my-lisp-hook ()
  (elisp-slime-nav-mode)
  (turn-on-eldoc-mode)
  )
(add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)

; Org
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

; Dired
(require 'dired-x)

; Powerline
;(powerline-default-theme)

; TODO
; evil-org-mode
; expand-region
; helm
; smex
; magit
; ace-jump
; god-mode??

(provide 'init)
;;; init.el ends here
