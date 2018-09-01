;;; use-tramp.el ---  tramp mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package tramp
  :init (mapc (lambda (word)
                (add-to-list 'password-word-equivalents word))
              '("code" "key" "token"))
  :config (setq remote-file-name-inhibit-cache nil
                tramp-default-method           "ssh"
                tramp-persistency-file-name    (expand-file-name "tramp.el"
                                                                 vs-emacs-cache-dir)
                tramp-verbose                  1
                vc-ignore-dir-regexp           (format "%s\\|%s"
                                                       vc-ignore-dir-regexp
                                                       tramp-file-name-regexp)))

(provide 'use-tramp)
;;; set-tramp.el ends here
