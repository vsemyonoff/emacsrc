;;; use-dired-ranger.el ---  dired-ranger settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'dired
  (if (not (straight-use-package 'dired-ranger))
      (warn "===> Can't install 'dired-ranger'")

    ;; Keybindings
    (define-key dired-mode-map (kbd "M-w")   #'dired-ranger-copy )
    (define-key dired-mode-map (kbd "C-w")   #'dired-ranger-move )
    (define-key dired-mode-map (kbd "C-y")   #'dired-ranger-paste)
    )
  )

(provide 'use-dired-ranger)
;;; use-dired-ranger.el ends here
