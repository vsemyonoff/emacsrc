;;; use-dired+.el ---  dired+ settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package dired+
  :straight (:host github :repo "emacsmirror/dired-plus")
  :after (dired-x)
  :config (diredp-toggle-find-file-reuse-dir 1) ; Reuse buffer by default
  :bind (:map dired-mode-map
              ("<left>"   . diredp-up-directory-reuse-dir-buffer)
              ("C-<down>" . nil)
              ("C-<up>"   . nil)))

(provide 'use-dired+)
;;; use-dired+.el ends here
