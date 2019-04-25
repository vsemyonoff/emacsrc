;;; set-paren.el ---  show paren mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(add-hook 'vs-emacs-config-hook #'show-paren-mode)

(with-eval-after-load 'paren
  (setq blink-matching-paren               t
        show-paren-delay                   0.05
        show-paren-highlight-openparen     t
        show-paren-when-point-in-periphery t
        show-paren-when-point-inside-paren t
        )
  )

(provide 'set-paren)
;;; set-paren.el ends here
