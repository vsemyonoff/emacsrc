;;; use-peep-dired.el ---  preview for dired settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(with-eval-after-load 'dired
  (when (straight-use-package 'peep-dired)
    ;; Keybindings
    (define-key dired-mode-map (kbd "P") #'peep-dired)
    ;; Config
    (with-eval-after-load 'peep-dired)))

(provide 'use-peep-dired)
;;; use-peep-dired.el ends here
