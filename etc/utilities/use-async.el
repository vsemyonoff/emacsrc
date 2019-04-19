;;; use-async.el --- asynchronous library. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

;; Deprecated since Emacs 25.1 (use threads)

;; (if (not (straight-use-package 'async))
;;     (warn "===> Can't install 'async'")

;;   (defun vs|package-utils|upgrade-async ()
;;     (interactive)
;;     (async-start
;;      `(lambda ()
;;         ,(async-inject-variables "\\`\\(load-path\\|\\(package-.+\\)\\)")
;;         (require 'package-utils)
;;         (package-utils-upgrade-all)
;;         )
;;      (lambda (&optional done)
;;        (alert done :title "Upgrade"))
;;      )
;;     )
;;   )

(provide 'use-async)
;;; use-async.el ends here
