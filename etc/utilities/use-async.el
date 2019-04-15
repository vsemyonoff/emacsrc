;;; use-async.el --- asynchronous library. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(straight-use-package 'async)

;; (defun vs|package-utils|upgrade-async ()
;;   (interactive)
;;   (async-start
;;    `(lambda ()
;; 	  ,(async-inject-variables "\\`\\(load-path\\|\\(package-.+\\)\\)")
;; 	  (require 'package-utils)
;; 	  (package-utils-upgrade-all))
;;    (lambda (&optional done)
;;      (alert done :title "Upgrade"))))

(provide 'use-async)
;;; use-async.el ends here
