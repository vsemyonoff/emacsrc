;;; use-notmuch.el --- Notmuch mail user agent. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package notmuch
  :bind (("C-c m" . notmuch))
  :init
  (setq notmuch-init-file
        (expand-file-name "easymail-init" user-emacs-directory)))

(use-package gnus-alias
  :bind (:map message-mode-map
              ("<f12>" . gnus-alias-select-identity))
  :hook (message-setup . gnus-alias-determine-identity)
  )

;; (if (not (straight-use-package 'vdirel))
;;     (warn "===> Can't install 'vdirel'")

;;   (ignore "Config goes here")
;;   (require 'vdirel)
;;   )

(provide 'use-notmuch)
;;; use-notmuch.el ends here
