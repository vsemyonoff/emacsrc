;;; set-whitespace.el ---  unneded spaces highlight and cleanup. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Triggers
(add-hook 'conf-mode-hook   #'whitespace-mode)
(add-hook 'prog-mode-hook   #'whitespace-mode)
(add-hook 'text-mode-hook   #'whitespace-mode)

;; Config
(with-eval-after-load 'whitespace
  (add-hook 'before-save-hook #'delete-trailing-whitespace)
  (setq whitespace-line-column fill-column
        whitespace-style       '(face tabs empty trailing lines-tail))
  )

(provide 'set-whitespace)
;;; set-whitespace.el ends here
