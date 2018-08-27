;;; use-paren.el ---  show paren mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package paren
  :config (setq show-paren-delay                   0.1
                show-paren-highlight-openparen     t
                show-paren-when-point-inside-paren t  )
  :hook (vs-config-ui . show-paren-mode)
  )

(provide 'use-paren)
;;; use-paren.el ends here
