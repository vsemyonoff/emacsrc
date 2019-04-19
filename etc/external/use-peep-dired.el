;;; use-peep-dired.el ---  preview for dired settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(with-eval-after-load 'dired
  (if (not (straight-use-package 'peep-dired))
      (warn "===> Can't install 'peep-dired'")
    ;; Keybindings
    (define-key dired-mode-map (kbd "P") #'peep-dired)
    )
  )

(provide 'use-peep-dired)
;;; use-peep-dired.el ends here
