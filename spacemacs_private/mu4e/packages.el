;;; packages.el --- mu4e Layer packages File for Spacemacs
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

(defvar mu4e-packages
  '(
    ;; package mu4es go here
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar mu4e-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function mu4e/init-<package-mu4e>
;;
;; (defun mu4e/init-mu4e-maildirs-extension ()
  "Initialize my package"
  ;; (use-package mu4e-maildirs-extension
    ;; :config
    ;; (require 'mu4e-maildirs-extension)
    ;; (require 'mu4e-multi)
    ;; (mu4e-maildirs-extension)
    ;; )
  ;; )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
