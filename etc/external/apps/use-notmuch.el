;;; use-notmuch.el --- Notmuch mail user agent. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'notmuch))
    (warn "===> Can't install 'notmuch'")

  (setq notmuch-init-file (expand-file-name "easymail-init" user-emacs-directory))
  (global-set-key (kbd "C-c m") #'notmuch)

  ;; Multiple identities
  (if (not (straight-use-package 'gnus-alias))
      (warn "===> Can't install 'gnus-alias'")

    (add-hook 'message-setup-hook #'gnus-alias-determine-identity)

    (with-eval-after-load 'message
      (define-key message-mode-map (kbd "<f12>") #'gnus-alias-select-identity)
      )
    )
  )

(provide 'use-notmuch)
;;; use-notmuch.el ends here
