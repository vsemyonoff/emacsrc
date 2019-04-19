;;; use-dired+.el ---  dired+ settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(with-eval-after-load 'dired-x
  (if (not (straight-use-package 'dired+))
      (warn "===> Can't install 'dired+'")
    (require 'dired+)

    ;; Keybindings
    (define-key dired-mode-map (kbd "<left>")   #'diredp-up-directory)
    ;; (define-key dired-mode-map (kbd "<right>")  #'dired-find-file    )

    ;; Unbind keys
    (define-key dired-mode-map (kbd "C-<down>") nil)
    (define-key dired-mode-map (kbd "C-<up>")   nil)
    )
  )

(provide 'use-dired+)
;;; use-dired+.el ends here
