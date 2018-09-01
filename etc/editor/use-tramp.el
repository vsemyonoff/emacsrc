;;; use-tramp.el ---  tramp mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package tramp
  :init (mapc (lambda (word)
                (add-to-list 'password-word-equivalents word))
              '("code" "key" "token"))
  :config (setq tramp-default-method        "ssh"
                tramp-persistency-file-name (expand-file-name "tramp.el"
                                                              vs-emacs-cache-dir)))

(provide 'use-tramp)
;;; set-tramp.el ends here
