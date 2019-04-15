;;; set-paren.el ---  show paren mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

;; Triggers
(add-hook 'vs-emacs-config-hook #'show-paren-mode)

;; Conofig
(with-eval-after-load 'paren
  (setq blink-matching-paren               t
        show-paren-delay                   0.1
        show-paren-highlight-openparen     t
        show-paren-when-point-in-periphery t
        show-paren-when-point-inside-paren t))

(provide 'set-paren)
;;; set-paren.el ends here
