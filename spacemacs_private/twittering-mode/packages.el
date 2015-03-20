;;; packages.el --- twittering-mode Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar twittering-mode-packages
  '(
    epg
    twittering-mode
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar twittering-mode-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function twittering-mode/init-<package-twittering-mode>
;;
(defun twittering-mode/init-epg ())

(defun twittering-mode/init-twittering-mode ()
  (require 'twittering-mode)
  )
;  (setq twittering-use-master-password t))
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
