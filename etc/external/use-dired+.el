;;; use-dired+.el ---  dired+ settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(straight-use-package 'dired+)

;; Config
(with-eval-after-load 'dired-x
  (require 'dired+)
  (diredp-toggle-find-file-reuse-dir 1))

(provide 'use-dired+)
;;; use-dired+.el ends here
