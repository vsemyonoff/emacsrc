;;; use-notmuch.el --- Notmuch mail user agent. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'notmuch))
    (warn "===> Can't install 'notmuch'")

  (setq notmuch-init-file (expand-file-name "easymail-init" user-emacs-directory))

  (global-set-key (kbd "C-c m") #'notmuch)

  )

(provide 'use-notmuch)
;;; use-notmuch.el ends here
