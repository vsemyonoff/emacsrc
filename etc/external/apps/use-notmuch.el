;;; use-notmuch.el --- Notmuch mail user agent. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package notmuch
  :bind ("C-c m" . notmuch)
  :init (setq notmuch-init-file (expand-file-name "notmuch-init"
                                                  user-emacs-directory))
  )

(provide 'use-notmuch)
;;; use-notmuch.el ends here
