;;; use-dired+.el ---  dired+ settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(with-eval-after-load 'dired-x
  (when (straight-use-package 'dired+)
    (diredp-toggle-find-file-reuse-dir 1)
    ;; Keybindings
    (define-key dired-mode-map (kbd "<left>")   #'diredp-up-directory-reuse-dir-buffer)
    (define-key dired-mode-map (kbd "<right>")  #'diredp-find-file-reuse-dir-buffer   )
    ;; Unbind keys
    (define-key dired-mode-map (kbd "C-<down>") nil)
    (define-key dired-mode-map (kbd "C-<up>")   nil)))

(provide 'use-dired+)
;;; use-dired+.el ends here
