;;; extensions.el --- twittering-mode Layer extensions File for Spacemacs
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

(defvar twittering-mode-pre-extensions
  '(
    ;; pre extension twittering-modes go here
    )
  "List of all extensions to load before the packages.")

(defvar twittering-mode-post-extensions
  '(
    ;; post extension twittering-modes go here
    )
  "List of all extensions to load after the packages.")

;; For each extension, define a function twittering-mode/init-<extension-twittering-mode>
;;
;; (defun twittering-mode/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
